// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import {
  createSupabaseAdminClient,
  jsonResponse,
} from "../_shared/functions_utils.ts";

import { createArticlesFromRssFeed, fetchRss } from "../_shared/rss.ts";

const supabase = createSupabaseAdminClient();

Deno.serve(async (req) => {
  const { feed_id } = await req.json();

  if (!feed_id) {
    return jsonResponse({ "error:": "Missing feed_id" }, 400);
  }

  const { data, error } = await supabase
    .from("feeds")
    .select("*")
    .eq("feed_id", feed_id)
    .single();

  if (error) {
    return jsonResponse({ "error:": error.message }, 500);
  }

  if (!data) {
    return jsonResponse({ "error:": "Feed not found" }, 404);
  }

  const feed = data;

  try {
    const rssFeed = await fetchRss(feed.feed_url);
    const articles = createArticlesFromRssFeed(rssFeed);

    if (!articles || articles.length === 0) {
      return jsonResponse({ "error:": "No articles found for this url" }, 404);
    }

    let articlesFetched = 0;

    for (const article of articles) {
      if (article.reference_url === null || article.title === null) {
        continue;
      }

      let isNew: boolean | undefined = undefined;

      if (article.published_at && feed.last_fetched) {
        isNew = article.published_at > feed.last_fetched;
      }

      if (isNew === undefined) {
        // Check if article already exists in db
        const previouslySavedArticle = await supabase
          .from("articles")
          .select("*")
          .eq("reference_url", article.reference_url)
          .single();

        isNew = previouslySavedArticle.data === null;
      }

      if (!isNew) {
        continue;
      }

      await supabase
        .from("articles")
        .insert({
          feed_id: feed_id,
          reference_url: article.reference_url,
          title: article.title,
          description: article.description,
          thumbnail_url: article.thumbnail_url,
          published_at: article.published_at,
        });

      articlesFetched++;
    }

    await supabase
      .from("feeds")
      .update({
        last_fetched: new Date(),
      })
      .eq("feed_id", feed_id);

    console.log(
      `Fetched ${articlesFetched} new articles for feed ${feed_id} (${feed.feed_url})`,
    );

    return jsonResponse({ message: "success" }, 200);
  } catch (error) {
    return jsonResponse({ error: error.message }, 500);
  }
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/sync_feed_articles' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
