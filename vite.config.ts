import { defineConfig } from "vitest/config";
import { paraglide } from "@inlang/paraglide-sveltekit/vite";
import { sveltekit } from "@sveltejs/kit/vite";
import { kitRoutes } from "vite-plugin-kit-routes";
import type { KIT_ROUTES } from "$lib/ROUTES";

export default defineConfig({
	plugins: [
		sveltekit(),
		paraglide({
			project: "./project.inlang",
			outdir: "./src/lib/paraglide",
		}),
		kitRoutes<KIT_ROUTES>(),
	],

	test: {
		include: ["src/**/*.{test,spec}.{js,ts}"],
	},
});
