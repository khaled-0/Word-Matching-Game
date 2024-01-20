<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	import ScaleControl from './ScaleControl.svelte';
	import TogglePreference from './TogglePreference.svelte';
	export let dialog: HTMLDialogElement;

	export let boardHint: boolean;
	export let boardScale: number;

	const dispatch = createEventDispatcher<{
		centerBoard: void;
		scaleUpdate: number;
	}>();
</script>

<dialog bind:this={dialog} class="global-container-bg">
	<div class="title">
		<span>Preferences</span>
		<button class="rounded-xl h-5 w-5 bg-red-600" on:click={() => dialog.close()} />
	</div>
	<div class="body">
		<TogglePreference title="Board Hint" bind:checked={boardHint} />
		<ScaleControl
			on:centerBoard={() => dispatch('centerBoard')}
			on:scaleUpdate={(event) => (boardScale = event.detail)}
		/>
	</div>
</dialog>

<style lang="postcss">
	dialog {
		@apply w-9/12 large:w-5/12 h-4/6;
		@apply p-4 rounded-xl;
		@apply dark:text-platinum-800 text-rich_black-100;
	}

	.title {
		@apply text-xl;
		@apply flex gap-4 justify-between items-center;
	}

	.body {
		@apply p-2 mt-2 rounded-xl;
	}
</style>
