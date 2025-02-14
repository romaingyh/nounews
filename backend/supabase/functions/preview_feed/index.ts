// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

import { jsonResponse } from "../_shared/functions_utils.ts";
import { createArticlesFromRssFeed, fetchRss } from "../_shared/rss.ts";

Deno.serve(async (req) => {
  // TODO CHECK USER AUTH

  const { url } = await req.json();

  if (!url) {
    return jsonResponse({ error: "No url provided" }, 400);
  }

  try {
    const feed = await fetchRss(url);

    const articles = createArticlesFromRssFeed(feed);

    if (!articles || articles.length === 0) {
      return jsonResponse({ error: "No articles found for this url" }, 404);
    }

    return jsonResponse(
      {
        feed_title: feed.title.value,
        feed_url: url,
        articles: articles,
      },
      200,
    );
  } catch (error) {
    // We distinguish between different kinds of errors to returns human-friendly messages
    //console.log("Error for url", url, ":", error);

    return jsonResponse({ error: error.message }, 500);
  }
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/preview_feed' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"url":"https://auparfum.bynez.com/actualites"}'

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/preview_feed' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"url":"https://numerama.com/feed"}'

*/
