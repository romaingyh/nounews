// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import {
  createSupabaseAdminClient,
  jsonResponse,
} from "../_shared/functions_utils.ts";

const supabase = createSupabaseAdminClient();

Deno.serve(async (req) => {
  // TODO CHECK USER AUTH

  const { feed_title, feed_url } = await req.json();

  if (!feed_title || !feed_url) {
    return jsonResponse({ "error:": "Missing feed_title or feed_url" }, 400);
  }

  // check if there is an existing feed with same url
  let existing_feed = await supabase
    .from("feeds")
    .select("*")
    .eq("feed_url", feed_url)
    .single();

  if (existing_feed.data) {
    return jsonResponse(
      { "error:": "There is already a feed with this url" },
      400,
    );
  }

  // check if there is an existing feed with same name
  existing_feed = await supabase
    .from("feeds")
    .select("*")
    .eq("feed_title", feed_title)
    .single();

  if (existing_feed.data) {
    return jsonResponse(
      { "error:": "There is already a feed with this name" },
      400,
    );
  }

  const { data, error } = await supabase
    .from("feeds")
    .insert([
      {
        feed_title: feed_title,
        feed_url: feed_url,
        last_fetched: undefined,
      },
    ])
    .select("*");

  if (error) {
    return jsonResponse({ "error": error.message }, 500);
  }

  const feedId = data[0].feed_id;

  if (!feedId) {
    return jsonResponse({ "error:": "Feed not created" }, 500);
  }

  console.log(`Created feed ${feedId}`);

  // launch feed sync in the background
  // don't wait for it
  supabase.functions.invoke("sync_feed_articles", {
    body: JSON.stringify({ feed_id: feedId }),
  });

  return jsonResponse({ "feed_id": feedId }, 200);
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/add_feed' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"feed_title":"Numerama", "feed_url":"https://numerama.com/feed"}'

*/
