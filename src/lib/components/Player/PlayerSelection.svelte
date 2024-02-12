<script lang="ts">
	import type { Player } from '$lib/data/Player';
	import { Input } from 'flowbite-svelte';

	export let player: Player;
</script>

<div class="container" style="--color:{player.color}">
	<span class="color"><input type="color" bind:value={player.color} class="opacity-0 color" /></span
	>
	<Input bind:value={player.name} />
</div>

<style lang="postcss">
	.container {
		@apply flex items-center gap-1 large:gap-2 w-fit;
		@apply flex-1 basis-auto rounded-lg;
		@apply large:p-2 p-1;
		@apply bg-slate-100 dark:bg-gray-700;
	}

	.color {
		@apply h-4 w-4 large:h-6 large:w-6;
		@apply rounded-full flex-shrink-0;
		@apply cursor-pointer;
		background-color: var(--color);
	}
</style>
