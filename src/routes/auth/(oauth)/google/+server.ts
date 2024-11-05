import { route } from "$lib/ROUTES.js";
import { redirect } from "@sveltejs/kit";

export const GET = async ({ locals: { supabase }, url }) => {
	console.log(url.origin);
	console.log(`${url.origin}/auth/callback`);

	const { data } = await supabase.auth.signInWithOAuth({
		provider: "google",
		options: {
			redirectTo: `${url.origin}/auth/callback`,
		},
	});

	if (data.url) {
		redirect(307, data.url);
	}

	redirect(307, route("/auth/error"));
};
