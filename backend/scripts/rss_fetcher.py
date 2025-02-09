import os
from datetime import datetime, timezone

import feedparser
from dateutil.parser import parse
from dotenv import load_dotenv
from supabase import create_client

#####################################################
load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)
#####################################################


def fetch_rss(url):
    return feedparser.parse(url)


def postgresql_timestamp_to_datetime(timestamp):
    return datetime.fromisoformat(timestamp)


# Fetch all feeds
feeds = supabase.table("feeds").select("*").execute()

for feed in feeds.data:
    feed_id = feed["feed_id"]
    feed_last_fetched = (
        postgresql_timestamp_to_datetime(feed["last_fetched"])
        if feed["last_fetched"]
        else None
    )

    print(f"Fetching feed {feed_id}, last fetched: {feed_last_fetched}")

    rss_content = fetch_rss(feed["feed_url"])
    rss_items = rss_content["entries"]

    for item in rss_items:
        reference_url = item.link
        title = item.title
        description = item.summary if item.summary else None
        thumbnail_url = item.media_content[0]["url"] if item.media_content else None
        published_at = (
            parse(item.published).astimezone(timezone.utc) if item.published else None
        )

        if reference_url is None or title is None:
            continue

        if (
            published_at is not None
            and feed_last_fetched is not None
            and published_at <= feed_last_fetched
        ):
            continue

        # Check if article already exists
        previously_saved_article = (
            supabase.table("articles")
            .select("*")
            .eq("reference_url", reference_url)
            .execute()
        )

        if previously_saved_article.data:
            print("Article already exists")
            continue

        article = {
            "feed_id": feed_id,
            "reference_url": reference_url,
            "title": title,
            "description": description,
            "thumbnail_url": thumbnail_url,
            "published_at": str(published_at),
        }

        supabase.table("articles").insert(article).execute()

    # Update last fetched time
    supabase.table("feeds").update(
        {"last_fetched": str(datetime.now(timezone.utc))}
    ).eq("feed_id", feed_id).execute()
