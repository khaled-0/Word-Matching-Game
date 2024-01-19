<script lang="ts">
	import type { Player } from '$lib/data/Player';
	import type { PlayerScore } from '$lib/data/PlayerScore';
	import { createEventDispatcher } from 'svelte';

	export let player: Player;
	export let myTurn: boolean;
	export let playerScore: PlayerScore;

	const dispatch = createEventDispatcher<{ onPlayerClick: void }>();
</script>

<button
	class="container global-subcontainer-bg"
	title={`Click to show detailed score of ${player.name}`}
	style="--color:{player.color}"
	data-active={myTurn}
	on:click={() => dispatch('onPlayerClick')}
>
	<div class="color" />
	<span class="name">{player.name}</span>
	<span class="score">{playerScore.score}</span>
</button>

<style lang="postcss">
	[data-active='true'] {
		@apply border-2;
		border-color: var(--color);
	}

	.container {
		@apply flex justify-start items-center gap-1;
		@apply flex-1  large:basis-full rounded-lg w-fit;
		@apply cursor-pointer large:p-2 p-0.5;
	}

	.color {
		@apply h-4 w-4;
		@apply rounded-xl;
		background-color: var(--color);
	}

	.name {
		@apply text-sm large:text-base;
		@apply flex-1 text-start;
		@apply large:px-2;
	}

	.score {
		@apply py-0.5 px-1 rounded;
		@apply text-sm large:text-base;
		background-color: var(--color);
	}
</style>
