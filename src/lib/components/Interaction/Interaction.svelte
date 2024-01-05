<script lang="ts">
	import type { Player } from '$lib/data/Player';
	import Letter from '../Letter.svelte';
	import PlayerChip from '../PlayerChip.svelte';
	import { createEventDispatcher } from 'svelte';

	export let color: string;
	export let playersList: Player[];
	export let currentPlayer: Player;

	const dispatcher = createEventDispatcher<{ toggleBoardHint: boolean }>();

	let boardHint: boolean = true;
</script>

<div class="interaction-area global-container-bg">
	<div>
		<div class="letters-container">
			{#each 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('') as value}
				<Letter {value} {color} />
			{/each}
		</div>
	</div>

	<div>
		<div class="players-container">
			{#each playersList as player}
				<PlayerChip
					{player}
					myTurn={player == currentPlayer}
					on:colorChange={(event) => {
						player.color = event.detail.color;
						color = currentPlayer.color;
					}}
				/>
			{/each}
		</div>
		<div>
			Board Hint {boardHint}
			<input
				type="checkbox"
				bind:checked={boardHint}
				on:change={() => dispatcher('toggleBoardHint', boardHint)}
			/>
		</div>
	</div>
</div>

<style lang="postcss">
	.interaction-area {
		@apply h-full p-2 large:p-4;
		@apply flex flex-col justify-between;
		@apply rounded-2xl border-2;
		@apply border-gray-300 dark:border-gray-700;
	}

	.letters-container {
		@apply flex flex-wrap gap-1;
	}

	.players-container {
		@apply flex flex-wrap;
		@apply gap-1;
	}
</style>
