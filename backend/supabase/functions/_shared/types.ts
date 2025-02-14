export type Article = {
    article_id: number | undefined;
    feed_id: number | undefined;
    title: string;
    description: string | undefined;
    reference_url: string;
    thumbnail_url: string | undefined;
    published_at: Date | undefined;
};

export type GeminiModelName =
    | "gemini-1.5-pro"
    | "gemini-1.5-flash-8b"
    | "gemini-1.5-flash"
    | "gemini-2.0-flash-lite-preview-02-05"
    | "gemini-2.0-flash";
