<script lang="ts">
	import { signInWithGoogle } from '$lib/auth';
	import { onMount } from 'svelte';

	onMount(() => {
		signInWithGoogle();
	});
</script>
