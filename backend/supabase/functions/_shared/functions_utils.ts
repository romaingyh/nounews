import { createClient, SupabaseClient } from "jsr:@supabase/supabase-js";

export function createSupabaseAdminClient(): SupabaseClient {
    return createClient(
        Deno.env.get("SUPABASE_URL") ?? "",
        Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "",
    );
}

export function jsonResponse(
    data: Record<string, unknown>,
    status: number,
): Response {
    return new Response(JSON.stringify(data), {
        headers: {
            "Content-Type": "application/json",
        },
        status,
    });
}
