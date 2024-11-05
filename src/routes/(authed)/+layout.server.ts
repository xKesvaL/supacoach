import { redirect } from "@sveltejs/kit";

export const load = async ({ locals: { safeGetSession }, depends }) => {
	// Declare a dependency so the layout can be invalidated, for example, on
	// session refresh.
	depends("supabase:auth");

	const { session, user } = await safeGetSession();

	if (!session || !user) {
		redirect(303, "/auth/login");
	}

	return { session, user };
};
