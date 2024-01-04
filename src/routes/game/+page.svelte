<script lang="ts">
	import Board from '$lib/components/Board/Board.svelte';
	import Interaction from '$lib/components/Interaction/Interaction.svelte';
	import makeElementDragable from '$lib/components/utils/makeElementDragable';
	import type { BoardSize, PlayerCount } from '$lib/data/Board';
	import { PlayersList, type Player } from '$lib/data/Player';
	import { onMount } from 'svelte';

	let playerCount: PlayerCount = 4;
	let boardSize: BoardSize = 10;
	let boardHint: boolean = false;

	let color = PlayersList[0].color;
	let currentPlayer: Player = PlayersList[0];

	const playersList = PlayersList;
	playersList.length = playerCount;

	let boardScale = 1;

	onMount(() => {
		makeElementDragable(document.getElementById('game-board')!);
	});
</script>

<div style:scale={boardScale} class="board-container absolute" id="game-board">
	<Board
		{boardSize}
		{playerCount}
		{boardHint}
		on:onPlayerSubmit={(event) => {
			color = playersList[event.detail.nextPlayerId].color;
			currentPlayer = playersList[event.detail.nextPlayerId];
		}}
	/>
</div>

<div class="interaction-container">
	<!-- <button class="z-20" on:click={() => (boardScale += 1)}>++++++</button>
	<button class="z-20" on:click={() => (boardScale -= 1)}>-------</button> -->

	<Interaction
		{color}
		{currentPlayer}
		{playersList}
		on:toggleBoardHint={(event) => (boardHint = event.detail)}
	/>
</div>

<style lang="postcss">
	.board-container {
		@apply left-0 right-0 top-0 bottom-0;
		@apply flex items-center justify-center;
		@apply large:w-3/4 h-4/6 large:h-full;
		overflow: hidden;
	}

	.interaction-container {
		@apply fixed h-2/6;
		@apply bottom-1 right-1 left-1;

		@apply large:w-1/4 large:h-[unset];
		@apply large:top-1 large:left-[unset];
	}
</style>
