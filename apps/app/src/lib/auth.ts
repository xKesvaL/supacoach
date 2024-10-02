import { createAuthClient } from "better-auth/svelte";
export const authClient = createAuthClient({
	baseURL: "http://localhost:3000", // the base url of your auth server
});

export const signInWithGoogle = async () => {
	const data = await authClient.signIn.social({
		provider: "google",
	});

	console.log(data);

	return data;
};
