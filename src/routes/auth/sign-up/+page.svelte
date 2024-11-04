<script lang="ts">
	import AuthWithEmailForm from '$lib/components/auth/AuthWithEmailForm.svelte';
	import type { PageData } from './$types';

	interface Props {
		data: PageData;
	}

	let { data }: Props = $props();
</script>

<AuthWithEmailForm data={data.form} type="signup" />
