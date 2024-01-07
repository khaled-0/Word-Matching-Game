<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	import Preference from './Preference.svelte';
	export let dialog: HTMLDialogElement;

	const dispatch = createEventDispatcher<{}>();
</script>

<dialog bind:this={dialog}>
	<h2>Preference</h2>
	<Preference />
</dialog>

<!-- https://svelte.dev/repl/885653f873284f7880490dcdd1200238?version=3.48.0 -->
