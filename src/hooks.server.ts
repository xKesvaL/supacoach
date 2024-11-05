import { redirect, type Handle } from "@sveltejs/kit";
import { i18n } from "$lib/i18n";
import { sequence } from "@sveltejs/kit/hooks";
import { createServerClient } from "@supabase/ssr";

import {
	PUBLIC_SUPABASE_ANON_KEY,
	PUBLIC_SUPABASE_URL,
} from "$env/static/public";
import { UNAUTHED_PATHS } from "$lib/config";

const handleParaglide: Handle = i18n.handle();

const handleGlobal: Handle = async ({ event, resolve }) => {
	event.locals.supabase = createServerClient(
		PUBLIC_SUPABASE_URL,
		PUBLIC_SUPABASE_ANON_KEY,
		{
			cookies: {
				get: (key) => event.cookies.get(key),
				/**
				 * SvelteKit's cookies API requires `path` to be explicitly set in
				 * the cookie options. Setting `path` to `/` replicates previous/
				 * standard behavior.
				 */
				set: (key, value, options) => {
					event.cookies.set(key, value, { ...options, path: "/" });
				},
				remove: (key, options) => {
					event.cookies.delete(key, { ...options, path: "/" });
				},
			},
		},
	);

	/**
	 * Unlike `supabase.auth.getSession()`, which returns the session _without_
	 * validating the JWT, this function also calls `getUser()` to validate the
	 * JWT before returning the session.
	 */
	event.locals.safeGetSession = async () => {
		const {
			data: { session },
		} = await event.locals.supabase.auth.getSession();
		if (!session) {
			return { session: null, user: null };
		}

		const {
			data: { user },
			error,
		} = await event.locals.supabase.auth.getUser();
		if (error) {
			// JWT validation has failed
			return { session: null, user: null };
		}

		return { session, user };
	};

	return resolve(event, {
		filterSerializedResponseHeaders(name) {
			/**
			 * Supabase libraries use the `content-range` and `x-supabase-api-version`
			 * headers, so we need to tell SvelteKit to pass it through.
			 */
			return name === "content-range" || name === "x-supabase-api-version";
		},
	});
};

const authGuard: Handle = async ({ event, resolve }) => {
	const { session, user } = await event.locals.safeGetSession();
	event.locals.session = session;
	event.locals.user = user;

	if (
		!event.locals.session &&
		!event.url.pathname.startsWith("/auth") &&
		!UNAUTHED_PATHS.some(({ path, startWith }) =>
			startWith
				? event.url.pathname.startsWith(path)
				: event.url.pathname.split("/").slice(1).includes(path),
		)
	) {
		redirect(303, "/auth/login");
	}

	if (event.locals.session && event.url.pathname === "/auth") {
		redirect(303, "/private");
	}

	return resolve(event);
};

export const handle: Handle = sequence(
	handleParaglide,
	handleGlobal,
	// authGuard,
);
