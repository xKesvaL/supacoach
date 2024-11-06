<script lang="ts">
	import type { PageData } from './$types';

	interface Props {
		data: PageData;
	}

	let { data }: Props = $props();
</script>

<main>
	{#await data.profiles}
		<p>Loading...</p>
	{:then profiles}
		{#each profiles as profile}
			<div>
				<h2>{profile.id}</h2>
				<p>{profile.role}</p>
			</div>
		{/each}
	{/await}
</main>
