<script lang="ts">
	import type { Player } from '$lib/data/Player';
	import { createEventDispatcher } from 'svelte';

	export let player: Player;
	export let myTurn: Boolean;

	const dispatch = createEventDispatcher<{ colorChange: { color: string } }>();
	let customColor: string;
</script>

<button
	class="label"
	style="--color:{player.color}"
	data-active={myTurn}
	on:click={() => document.getElementById(`color-picker-${player.id}`)?.click()}
	>Player {player.id + 1}{myTurn ? "'s Turn" : ''}
</button>

<input
	id={`color-picker-${player.id}`}
	class="hidden"
	type="color"
	bind:value={customColor}
	on:change={() => dispatch('colorChange', { color: customColor })}
/>

<style lang="postcss">
	.label {
		border-color: var(--color);
		@apply border rounded-xl;
		@apply p-2 w-fit min-w-0 min-h-0;
		@apply overflow-hidden;
		@apply basis-auto flex-1;
	}

	[data-active='true'] {
		background-color: var(--color);
	}
</style>
