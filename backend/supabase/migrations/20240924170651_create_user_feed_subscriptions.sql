CREATE TABLE "public"."user_feed_subscriptions" (
    "user_id" uuid REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    "feed_id" bigint REFERENCES public.feeds(feed_id) ON DELETE CASCADE NOT NULL,
    PRIMARY KEY ("user_id", "feed_id")
)