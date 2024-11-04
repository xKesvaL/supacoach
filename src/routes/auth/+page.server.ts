import { fail, superValidate } from "sveltekit-superforms";
import { authWithEmailSchema } from "$lib/db/schemas/auth";
import { zod } from "sveltekit-superforms/adapters";
import { redirect, type Actions } from "@sveltejs/kit";

export const actions = {
	login: async ({ request, locals: { supabase } }) => {
		const loginForm = await superValidate(request, zod(authWithEmailSchema));

		if (!loginForm.valid) return fail(400, { loginForm });

		const { email, password } = loginForm.data;

		const { error } = await supabase.auth.signInWithPassword({
			email,
			password,
		});
		if (error) {
			console.error(error);
			return fail(400, { loginForm });
		}

		redirect(303, "/authed");
	},
	register: async ({ request, locals: { supabase } }) => {
		const registerForm = await superValidate(request, zod(authWithEmailSchema));

		if (!registerForm.valid) return fail(400, { registerForm });

		const { email, password } = registerForm.data;

		const { error } = await supabase.auth.signUp({ email, password });
		if (error) {
			console.error(error);
			return fail(400, { registerForm });
		}

		redirect(303, "/");
	},
} satisfies Actions;
