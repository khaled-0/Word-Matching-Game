<script lang="ts">
	import Board from '$lib/components/Board/Board.svelte';
	import Interaction from '$lib/components/Interaction/Interaction.svelte';
	import makeElementDragable from '$lib/utils/makeHTMLElementDragable';
	import type { BoardSize, PlayerCount } from '$lib/data/Board';
	import { PlayersList, type Player } from '$lib/data/Player';
	import { onMount } from 'svelte';
	import { calculateInputScore, type PlayerScore } from '$lib/data/PlayerScore';
	import PreferenceDialog from '$lib/components/Preference/PreferenceDialog.svelte';
	import type { PageData } from './$types';
	import * as PreferenceHandler from '$lib/components/Preference/PreferenceHandler';

	export let data: PageData;

	let playerCount: PlayerCount = data.players;
	let boardSize: BoardSize = data.board;

	const playersList = Array.from(PlayersList);
	playersList.length = data.players;

	data.names?.forEach((name, index) =>
		playersList[index] ? (playersList[index].name = name) : null
	);
	data.colors?.forEach((color, index) =>
		playersList[index] ? (playersList[index].color = color) : null
	);

	let currentPlayer: Player = playersList[0];

	const playerScores: Array<PlayerScore> = Array(playerCount)
		.fill(null)
		.map((_, i) => {
			return { playerId: i, score: 0, words: [] };
		});

	let preferenceDialog: HTMLDialogElement;
	let boardHint: boolean = false;
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
		currentPlayer = playersList[data.nextPlayerId];

		const existingWords: string[] = [];
		playerScores.forEach((score) => {
			existingWords.push(...score.words);
		});

		calculateInputScore(data.boardData, data.submitRow, data.submitColumn, existingWords)
			.then((result) => {
				playerScores[data.submittedPlayerId].score += result.score;
				playerScores[data.submittedPlayerId].words.push(...result.words);
				//TODO Visualize scores
			})
			.catch((err) => {
				//TODO
				console.log(err);
			});
	}

	function handleGameOver(): void {
		throw new Error('Function not implemented.');
	}
</script>

<div style:scale={boardScale} class="board-container" id="game-board">
	<Board
		{boardSize}
		{playerCount}
		{boardHint}
		focusColor={currentPlayer.color}
		on:playerSubmit={handlePlayerSubmit}
		on:gameOver={handleGameOver}
	/>
</div>

<div class="interaction-container">
	<Interaction
		{currentPlayer}
		{playersList}
		{playerScores}
		on:preferenceClicked={() => preferenceDialog.showModal()}
	/>
</div>

<PreferenceDialog
	bind:dialog={preferenceDialog}
	bind:boardHint
	bind:boardScale
	on:centerBoard={() => {
		PreferenceHandler.centerBoard(document.getElementById('game-board'));
	}}
/>

<style lang="postcss">
	.board-container {
		@apply left-0 right-0 top-0 bottom-0;
		@apply fixed flex items-center justify-center;
		@apply w-full large:w-3/4 h-4/6 large:h-full;
		@apply transition-[scale];
	}

	.interaction-container {
		@apply fixed h-2/6;
		@apply bottom-1 right-1 left-1;

		@apply large:w-1/4 large:h-[unset];
		@apply large:top-1 large:left-[unset];
	}
</style>
