<script lang="ts">
	import Board from '$lib/components/Board/Board.svelte';
	import Letter from '$lib/components/Letter.svelte';
	import PlayerChip from '$lib/components/PlayerChip.svelte';
	import type { BoardSize, PlayerCount } from '$lib/data/Board';
	import { PlayersList, type Player } from '$lib/data/Player';

	let playerCount: PlayerCount = 4,
		boardSize: BoardSize = 10;
	let placeholder: boolean = false;

	let color = PlayersList[0].color;
	let currentPlayer: Player = PlayersList[0];

	const playersList = PlayersList;
	playersList.length = playerCount;
</script>

<div class="game-container">
	<div class="board-container">
		<Board
			{boardSize}
			{playerCount}
			{placeholder}
			on:onPlayerSubmit={(event) => {
				color = playersList[event.detail.nextPlayerId].color;
				currentPlayer = playersList[event.detail.nextPlayerId];
			}}
		/>
	</div>

	<div class="interaction-area">
		<div class="letters-container">
			{#each 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('') as value}
				<Letter {value} {color} />
			{/each}
		</div>

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
			<p class="mx-auto text-platinum-500">Tap to customize</p>
		</div>
		Placeholder Hint
		<input type="checkbox" bind:checked={placeholder} />
	</div>
</div>

<style lang="postcss">
	.game-container {
		@apply flex p-4 justify-center;
		height: 100svh;
	}

	.board-container {
		@apply large:w-3/4;
		@apply flex justify-center items-start large:items-center;
	}

	.interaction-area {
		@apply large:w-1/4;
		@apply fixed large:relative;
		@apply bottom-1 left-1 right-1;

		@apply flex flex-col justify-between;

		@apply bg-rich_black-100 p-2;
		@apply border-2 border-slate-700 rounded-2xl;
	}

	.letters-container {
		gap: 1rem;
	}

	.players-container {
		@apply flex flex-wrap;
		@apply gap-1;
	}
</style>
