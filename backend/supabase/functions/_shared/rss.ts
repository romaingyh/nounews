import { Feed, parseFeed } from "jsr:@mikaelporttila/rss@*";
import { GoogleGenerativeAI } from "npm:@google/generative-ai";
import { Article, GeminiModelName } from "./types.ts";

/**
 * Fetch RSS feed from url and parse it
 * @param {string} url
 * @returns {Promise<Feed>}
 */
export async function fetchRss(url: string): Promise<Feed> {
    try {
        const response = await fetch(url);

        const text = await response.text();

        try {
            const feed = await parseFeed(text);
            return feed;
        } catch (error) {
            if (
                error instanceof Error &&
                error.message == "Type html is not supported"
            ) {
                return createRssFromHtml(text);
            }

            throw error;
        }
    } catch (error) {
        if (error instanceof Error) {
            if (error.name === "TypeError") {
                throw new Error(
                    `Can't connect to ${url}. Is the URL correct?`,
                );
            }

            if (error.message.includes("network")) {
                throw new Error(
                    `Can't connect to ${url}. Is your network connection working?`,
                );
            }
        }

        throw error;
    }
}

/**
 * Use OpenAI api to create an rss feed from html
 * @param {string} html
 * @returns {Promise<Feed>}
 */
async function createRssFromHtml(
    html: string,
    modelName: GeminiModelName = "gemini-2.0-flash-lite-preview-02-05",
): Promise<Feed> {
    const systemPrompt =
        "I'll give you html code from a website news page. You must identify articles and export them to RSS xml formt." +
        'For rss header use : "<rss xmlns:atom="http://www.w3.org/2005/Atom" xmlns:media="http://search.yahoo.com/mrss/" xmlns:content="http://purl.org/rss/1.0/modules/content/" version="2.0">' +
        "Don't stop in the middle, find all possible articles." +
        "Don't forget images, add them in the xml as media:content tag." +
        "If some medias use relative paths, convert them to absolute including protocol." +
        "When you extract title, keep only relevant part. For example: 'The New York Times - News' should be 'The New York Times'." +
        "Your xml response will be directly used so answer only xml.";

    const apiKey = Deno.env.get("GEMINI_API_KEY");
    if (!apiKey) {
        throw new Error("Missing GEMINI_API_KEY environment variable");
    }

    const genAI = new GoogleGenerativeAI(apiKey);

    const model = genAI.getGenerativeModel({
        model: modelName,
        systemInstruction: systemPrompt,
    });

    const result = await model.generateContent(html);

    try {
        const feed = await parseFeed(result.response.text());
        return feed;
    } catch (error) {
        if (error.name === "TypeError") {
            throw new Error("No articles found for this url");
        }

        throw error;
    }
}

/**
 * Use RSS feed to create an array of articles
 * @param {Feed} feed
 * @returns {Article[]}
 */
export function createArticlesFromRssFeed(feed: Feed): Article[] {
    const articles: Article[] = [];

    for (const item of feed.entries) {
        const title = item.title?.value;
        const referenceUrl = item.links[0].href;

        if (!referenceUrl || !title) {
            continue;
        }

        const description = item.description?.value;
        const publishedAt = item.published;

        let thumbnailUrl = undefined;

        // try to load thumbnail from media:content
        const mediaContent = item["media:content"];
        if (mediaContent) {
            thumbnailUrl = mediaContent?.find(
                (content) =>
                    content.type === "image" || content.medium === "image",
            )?.url;

            if (!thumbnailUrl) {
                thumbnailUrl = mediaContent[0].url;
            }
        }

        // if not found, try to load thumbnail from content:encoded img html tag
        if (!thumbnailUrl) {
            const contentEncoded = item["content"];
            thumbnailUrl = contentEncoded?.value?.match(/<img.*?src="([^"]*)"/)
                ?.[1];
        }

        articles.push({
            article_id: undefined,
            feed_id: undefined,
            reference_url: referenceUrl,
            title: title,
            description: escapeHtml(description),
            thumbnail_url: thumbnailUrl,
            published_at: publishedAt,
        });
    }

    return articles;
}

function escapeHtml(unsafe: string | undefined): string | undefined {
    if (unsafe === undefined) {
        return unsafe;
    }

    return unsafe.replace(/<[^>]*>/g, "")
        .replace(/^\s+|\s+$/g, "")
        .replace(/\s+/g, " ");
}
