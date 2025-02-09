// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

//import { createClient } from "https://esm.sh/@supabase/supabase-js@2.0.0";

import { createArticlesFromRssFeed, fetchRss } from "../_utils/rss_utils.ts";

Deno.serve(async (req) => {
  // TODO CHECK USER AUTH

  const { url } = await req.json();

  if (!url) {
    return new Response("No url provided", { status: 400 });
  }

  try {
    const feed = await fetchRss(url);

    const articles = createArticlesFromRssFeed(feed);

    if (!articles || articles.length === 0) {
      return new Response("No articles found for this url", { status: 404 });
    }

    return new Response(
      JSON.stringify({
        "feed_title": feed.title.value,
        "articles": articles,
      }),
      {
        headers: {
          "Content-Type": "application/json",
        },
        status: 200,
      },
    );
  } catch (error) {
    // We distinguish between different kinds of errors to returns human-friendly messages
    //console.log("Error for url", url, ":", error);

    return new Response(error.message, { status: 500 });
  }
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/fetch_articles' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"url":"https://auparfum.bynez.com/actualites"}'

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/fetch_articles' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"url":"https://numerama.com/feed"}'

*/
