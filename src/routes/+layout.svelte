<script lang="ts">
	import { i18n } from '$lib/i18n';
	import { ParaglideJS } from '@inlang/paraglide-sveltekit';
	import '../app.css';
	import { onMount, type Snippet } from 'svelte';
	import type { PageData } from './$types.js';
	import { invalidate } from '$app/navigation';

	interface Props {
		children: Snippet;
		data: PageData;
	}

	let { children, data }: Props = $props();

	const { supabase, session, user } = data;

	onMount(() => {
		const { data } = supabase.auth.onAuthStateChange((_, newSession) => {
			if (newSession?.expires_at !== session?.expires_at) {
				invalidate('supabase:auth');
			}
		});

		return () => data.subscription.unsubscribe();
	});

	$inspect({ session, user });
</script>

<ParaglideJS {i18n}>
	{@render children()}
</ParaglideJS>
