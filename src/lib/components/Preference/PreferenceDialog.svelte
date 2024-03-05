<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	import ScaleControl from './ScaleControl.svelte';
	import TogglePreference from './TogglePreference.svelte';
	import { Modal } from 'flowbite-svelte';
	export let open: boolean;

	export let boardHint: boolean;
	export let boardScale: number;

	const dispatch = createEventDispatcher<{
		centerBoard: void;
	}>();
</script>

<Modal class="divide-none" size="sm" bind:open title="Preference">
	<div>
		<TogglePreference title="Board Hint" bind:checked={boardHint} />
		<ScaleControl bind:scale={boardScale} on:centerBoard={() => dispatch('centerBoard')} />
	</div>
</Modal>
