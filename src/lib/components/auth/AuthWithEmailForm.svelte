<script lang="ts">
	import * as Form from '$lib/components/ui/form/index.js';
	import { Input } from '$lib/components/ui/input/index.js';
	import { authWithEmailSchema, type AuthWithEmailSchema } from '$lib/db/schemas/auth';
	import { route } from '$lib/ROUTES';
	import { type SuperValidated, type Infer, superForm } from 'sveltekit-superforms';
	import { zodClient } from 'sveltekit-superforms/adapters';

	interface Props {
		data: SuperValidated<Infer<AuthWithEmailSchema>>;
		type: 'login' | 'signup';
	}

	let { data, type }: Props = $props();

	const form = superForm(data, {
		validators: zodClient(authWithEmailSchema)
	});

	const { form: formData, enhance } = form;
</script>

<form
	method="POST"
	use:enhance
	action={type === 'login' ? route('login /auth') : route('register /auth')}
>
	<Form.Field {form} name="email">
		<Form.Control>
			{#snippet children({ props })}
				<Form.Label>Email</Form.Label>
				<Input {...props} bind:value={$formData.email} />
			{/snippet}
		</Form.Control>
		<Form.FieldErrors />
	</Form.Field>
	<Form.Field {form} name="password">
		<Form.Control>
			{#snippet children({ props })}
				<Form.Label>Password</Form.Label>
				<Input {...props} bind:value={$formData.password} />
			{/snippet}
		</Form.Control>
		<Form.FieldErrors />
	</Form.Field>
	<Form.Button>Submit</Form.Button>
</form>
