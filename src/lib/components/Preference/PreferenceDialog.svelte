<script lang="ts">
	// import { createEventDispatcher } from 'svelte';
	import Preference from './Preference.svelte';
	export let dialog: HTMLDialogElement;

	// const dispatch = createEventDispatcher<{}>();
</script>

<!-- https://svelte.dev/repl/885653f873284f7880490dcdd1200238?version=3.48.0 -->

<dialog bind:this={dialog} class="global-subcontainer-bg">
	<div class="title">
		<span>Preferences</span>
		<button class="rounded-xl h-6 w-6 bg-red-600 border-2" on:click={() => dialog.close()} />
	</div>
	<Preference />
</dialog>

<style lang="postcss">
	dialog {
		@apply w-9/12 large:w-5/12 h-5/6 large:h-3/6;
		@apply p-4 rounded-xl;
		@apply dark:text-platinum-800 text-rich_black-100;
	}

	.title {
		@apply text-xl;
		@apply flex gap-4 justify-between items-center;
	}
</style>
