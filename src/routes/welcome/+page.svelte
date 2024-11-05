<script lang="ts">
	import Button from '$lib/components/ui/button/button.svelte';
	import { route } from '$lib/ROUTES';
</script>

Hi welcome

<Button href={route('/auth/login')}>I have account</Button>

<Button href={route('/auth/sign-up')}>I don't have account</Button>
