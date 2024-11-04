import type { LayoutServerLoad } from "./$types.js";
import { superValidate } from "sveltekit-superforms";
import { authWithEmailSchema } from "$lib/db/schemas/auth";
import { zod } from "sveltekit-superforms/adapters";

export const load: LayoutServerLoad = async () => {
	return {
		form: await superValidate(zod(authWithEmailSchema)),
	};
};
