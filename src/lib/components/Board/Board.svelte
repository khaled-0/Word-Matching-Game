<script lang="ts">
	import { onMount } from 'svelte';
	import BoardView from './BoardView.svelte';
	import { createEventDispatcher } from 'svelte';
	import { type Player } from '$lib/data/Player';
	import type { BoardSize } from '$lib/data/GameParameters';

	export let boardSize: BoardSize;
	export let players: Array<Player>;
	export let boardHint: boolean;
	export let focusColor: string;

	let currentPlayerId = 0;
	const words = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
	let boardData: HTMLInputElement[][] = Array.from(Array(boardSize), () =>
		new Array(boardSize).fill('')
	);

	const dispatch = createEventDispatcher<{
		playerSubmit: {
			nextPlayerId: number;
			submittedPlayerId: number;
			boardData: typeof boardData;
			submitRow: number;
			submitColumn: number;
		};
		gameOver: void;
	}>();

	function handleKeyPress(keyPress: KeyboardEvent, row: number, column: number) {
		const width = boardData[row].length,
			height = boardData.length;

		let prevCol = column - 1,
			nextCol = column + 1,
			prevRow = row - 1,
			nextRow = row + 1;

		switch (keyPress.key) {
			// TODO This is the shittiest way of doing this
			// Preserve tab functionality
			// loop to first input of next row when end of row is reached
			// or to first row and column when end of matrix is reached
			case 'Tab':
				if (nextCol != width) boardData[row][nextCol].focus();
				else if (row != height - 1) boardData[nextRow][0].focus();
				else boardData[0][0].focus();
				break;

			// Loop around single row with right and left arrows
			case 'ArrowRight':
				while (nextCol != width) {
					if (nextCol == width) {
						nextCol--;
						break;
					}
					if (!boardData[row][nextCol].disabled) break;
					nextCol++;
				}
				boardData[row][nextCol].focus();
				break;

			case 'ArrowLeft':
				while (prevCol + 1 != 0) {
					if (prevCol + 1 == 0) {
						prevCol++;
						break;
					}
					if (!boardData[row][prevCol].disabled) break;
					prevCol--;
				}
				boardData[row][prevCol].focus();
				break;

			// loop around single column with up and down arrows
			case 'ArrowUp':
				while (prevRow + 1 != 0) {
					if (prevRow + 1 == 0) {
						prevRow++;
						break;
					}
					if (!boardData[prevRow][column].disabled) break;
					prevRow--;
				}
				boardData[prevRow][column].focus();
				break;

			case 'ArrowDown':
				while (nextRow != height) {
					if (nextRow == height) {
						nextRow--;
						break;
					}
					if (!boardData[nextRow][column].disabled) break;
					nextRow++;
				}
				boardData[nextRow][column].focus();
				break;

			default:
				return handleLetterInput(keyPress, row, column);
		}

		return false;
	}

	function handleLetterInput(keyPress: KeyboardEvent, row: number, column: number): boolean {
		const boardField = boardData[row][column];
		if (boardField.value) return false;
		if (!words.includes(keyPress.key.toUpperCase())) return false;
		const submittedPlayerId = currentPlayerId;

		boardField.style.setProperty('--color', players[submittedPlayerId].color);
		boardField.dataset.playerId = submittedPlayerId.toString();

		boardField.value = keyPress.key.toUpperCase();
		boardField.disabled = true;
		boardField.dataset.focused = undefined;

		dispatch('playerSubmit', {
			nextPlayerId: switchToNextPlayer(),
			boardData: boardData,
			submittedPlayerId: submittedPlayerId,
			submitRow: row,
			submitColumn: column
		});

		// All the inputs has been filled
		if (getFilledBoardFieldLength() == boardSize * boardSize) dispatch('gameOver');

		return true;
	}

	function switchToNextPlayer(): number {
		currentPlayerId = (currentPlayerId + 1) % players.length;
		return currentPlayerId;
	}

	function getFilledBoardFieldLength(): number {
		// https://stackoverflow.com/a/48469793/16867144
		// Filter out the empty items by checking if the field is disabled
		// As the field gets disabled on valid input
		return boardData.reduce(
			(currentCount, row) => currentCount + row.filter((item) => item.disabled).length,
			0
		);
	}

	let focusedInputIndex: { row: number; column: number } | null;
	onMount(() => {
		document.addEventListener('keypress', (event) => {
			if (focusedInputIndex == null) return;
			handleKeyPress(event, focusedInputIndex.row, focusedInputIndex.column);
		});
	});
</script>

<BoardView
	{boardData}
	{boardHint}
	{focusColor}
	on:fieldFocus={(event) => (focusedInputIndex = event.detail)}
	on:fieldUnfocus={() => setTimeout(() => (focusedInputIndex = null), 500)}
	on:keyPress={(event) => handleKeyPress(event.detail.event, event.detail.row, event.detail.column)}
/>
