<script lang="ts">
	import Board from '$lib/components/Board/Board.svelte';
	import Interaction from '$lib/components/Interaction/Interaction.svelte';
	import makeElementDragable from '$lib/utils/makeHTMLElementDragable';
	import type { BoardSize, PlayerCount } from '$lib/data/Board';
	import { PlayersList, type Player } from '$lib/data/Player';
	import { onMount } from 'svelte';
	import { calculateInputScore, type PlayerScore } from '$lib/data/PlayerScore';

	let playerCount: PlayerCount = 4;
	let boardSize: BoardSize = 10;
	let boardHint: boolean = true;

	let color = PlayersList[0].color;
	let currentPlayer: Player = PlayersList[0];

	const playersList = PlayersList;
	playersList.length = playerCount;

	const playerScores: Array<PlayerScore> = Array(playerCount)
		.fill(null)
		.map((_, i) => {
			return { playerId: i, score: 0, words: [] };
		});

	let boardScale = 1;

	onMount(() => {
		makeElementDragable(document.getElementById('game-board')!);
	});

	async function handlePlayerSubmit(
		event: CustomEvent<{
			nextPlayerId: number;
			submittedPlayerId: number;
			boardData: HTMLInputElement[][];
			submitRow: number;
			submitColumn: number;
		}>
	) {
		const data = event.detail;
		color = playersList[data.nextPlayerId].color;
		currentPlayer = playersList[data.nextPlayerId];

		const existingWords: string[] = [];
		playerScores.forEach((score) => {
			existingWords.push(...score.words);
		});

		console.time('calc');
		calculateInputScore(data.boardData, data.submitRow, data.submitColumn, existingWords)
			.then((result) => {
				playerScores[data.submittedPlayerId].score += result.score;
				playerScores[data.submittedPlayerId].words.push(...result.words);
				//TODO Visualize scores
				console.timeEnd('calc');
			})
			.catch((err) => {
				//TODO
				console.log(err);
			});
	}
</script>

<div style:scale={boardScale} class="board-container" id="game-board">
	<Board {boardSize} {playerCount} {boardHint} on:onPlayerSubmit={handlePlayerSubmit} />
</div>

<div class="interaction-container">
	<!-- <button class="z-20" on:click={() => (boardScale += 1)}>++++++</button>
	<button class="z-20" on:click={() => (boardScale -= 1)}>-------</button> -->
	<!-- TODO Toggle Preference Window -->

	<Interaction
		{color}
		{currentPlayer}
		{playersList}
		{playerScores}
		on:toggleBoardHint={(event) => (boardHint = event.detail)}
	/>
</div>

<style lang="postcss">
	.board-container {
		@apply left-0 right-0 top-0 bottom-0;
		@apply fixed flex items-center justify-center;
		@apply w-full large:w-3/4 h-4/6 large:h-full;
	}

	.interaction-container {
		@apply fixed h-2/6;
		@apply bottom-1 right-1 left-1;

		@apply large:w-1/4 large:h-[unset];
		@apply large:top-1 large:left-[unset];
	}
</style>
