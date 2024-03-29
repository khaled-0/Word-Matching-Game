<script lang="ts">
	import Board from '$lib/components/Board/Board.svelte';
	import Interaction from '$lib/components/Interaction/Interaction.svelte';
	import makeElementDragable from '$lib/utils/makeHTMLElementDragable';
	import type { BoardSize, PlayerCount } from '$lib/data/GameParameters';
	import { PlayersList, type Player } from '$lib/data/Player';
	import { onMount } from 'svelte';
	import { calculateInputScore, type PlayerScore } from '$lib/data/PlayerScore';
	import PreferenceDialog from '$lib/components/Preference/PreferenceDialog.svelte';
	import type { PageData } from './$types';
	import * as PreferenceHandler from '$lib/components/Preference/PreferenceHandler';
	import preventTabClose from '$lib/utils/preventTabClose';
	import AlertBoard from '$lib/components/AlertBoard.svelte';
	import type { AlertMessages } from '$lib/data/AlertBoard';

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

	let preferenceDialogVisible: boolean;
	let alertMessages: AlertMessages = [];
	let boardHint: boolean = true;
	let boardScale = 1;

	onMount(() => {
		makeElementDragable(document.querySelector('.board-container')!);
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

		calculateInputScore(data.boardData, data.submitRow, data.submitColumn, existingWords).then(
			(result) => {
				playerScores[data.submittedPlayerId].score += result.score;
				playerScores[data.submittedPlayerId].words.push(...result.words);

				if (result.score) {
					const player = playersList[data.submittedPlayerId];
					alertMessages.push({
						message: result.words.join(','),
						title: `${player.name} +${result.score}`,
						color: player.color
					});
					alertMessages = alertMessages;
				}
			}
		);
	}

	function handleGameOver(): void {
		alert('Game Over');
		throw new Error('Function not implemented.');
	}
</script>

<div style:scale={boardScale} use:preventTabClose class="board-container">
	<Board
		{boardSize}
		players={playersList}
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
		on:preferenceClicked={() => (preferenceDialogVisible = true)}
	/>
</div>

<AlertBoard bind:alertMessages />

<PreferenceDialog
	bind:open={preferenceDialogVisible}
	bind:boardHint
	bind:boardScale
	on:centerBoard={() => {
		PreferenceHandler.centerBoard(document.querySelector('.board-container'));
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
