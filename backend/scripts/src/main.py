import os

from dotenv import load_dotenv
from supafunc.errors import FunctionsHttpError

from supabase import create_client
from supabase.lib.client_options import ClientOptions

#####################################################
load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

supabase = create_client(
    SUPABASE_URL, SUPABASE_KEY, options=ClientOptions(function_client_timeout=60)
)
#####################################################


def fetch_db_feeds() -> list:
    feeds = supabase.table("feeds").select("*").execute()
    return feeds.data


def sync_feed(feed: dict):
    feed_id = feed["feed_id"]
    feed_url = feed["feed_url"]

    print(f"=> Syncing feed {feed_id}: {feed_url}...")
    feed_id = feed["feed_id"]

    try:
        supabase.functions.invoke(
            "sync_feed_articles",
            invoke_options={"body": {"feed_id": feed_id}, "responseType": "json"},
        )
        print("   Done ✅")
    except FunctionsHttpError as e:
        # use red cross emoji
        print("   ❌ Error:", e.status, e.message)


def main():
    feeds = fetch_db_feeds()
    print(f"Found {len(feeds)} feeds to sync...\n")

    for feed in feeds:
        sync_feed(feed)
    
    print("\nAll feeds synced successfully!")


if __name__ == "__main__":
    main()
