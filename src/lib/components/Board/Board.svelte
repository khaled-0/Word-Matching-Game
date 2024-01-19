<script lang="ts">
	import { onMount } from 'svelte';
	import BoardView from './BoardView.svelte';
	import { createEventDispatcher } from 'svelte';
	import { PlayersList } from '$lib/data/Player';
	import type { BoardSize, PlayerCount } from '$lib/data/Board';

	export let boardSize: BoardSize;
	export let playerCount: PlayerCount;
	export let boardHint: boolean;
	export let focusColor: string;

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
			height = boardData.length,
			prevCol = column - 1,
			nextCol = column + 1,
			prevRow = row - 1,
			nextRow = row + 1;

		switch (keyPress.key) {
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
				nextCol != width ? boardData[row][nextCol].focus() : boardData[row][0].focus();
				break;

			case 'ArrowLeft':
				column != 0 ? boardData[row][prevCol].focus() : boardData[row][width - 1].focus();
				break;

			// loop around single column with up and down arrows
			case 'ArrowUp':
				row != 0 ? boardData[prevRow][column].focus() : boardData[height - 1][column].focus();
				break;

			case 'ArrowDown':
				row != height - 1 ? boardData[nextRow][column].focus() : boardData[0][column].focus();
				break;

			default: {
				const boardField = boardData[row][column];
				if (boardField.value) break;
				if (words.includes(keyPress.key.toUpperCase())) {
					const playerId = getPlayerId();

					boardField.style.setProperty('--color', getPlayerColor(playerId));
					boardField.dataset.playerId = playerId.toString();

					boardField.value = keyPress.key.toUpperCase();
					boardField.disabled = true;
					boardField.dataset.focused = undefined;

					//Now getPlayerId() != playerId; because an input is disabled
					dispatch('playerSubmit', {
						nextPlayerId: getPlayerId(),
						boardData: boardData,
						submittedPlayerId: playerId,
						submitRow: row,
						submitColumn: column
					});

					// All the inputs has been filled
					if (getFilledBoardFieldLength() == boardSize * boardSize) dispatch('gameOver');

					return true;
				}
			}
		}

		return false;
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

	function getPlayerId(): number {
		return getFilledBoardFieldLength() % playerCount;
	}

	function getPlayerColor(playerId: number): string {
		return PlayersList[playerId].color;
	}

	let focusedInputIndex: { row: number; column: number } | null;
	onMount(() => {
		document.addEventListener('keypress', (event) => {
			if (focusedInputIndex == null) return;
			handleKeyPress(event, focusedInputIndex.row, focusedInputIndex.column);
		});
	});
</script>

<!-- TODO better unfocus method rather than relying on timeout -->
<BoardView
	{boardData}
	{boardHint}
	{focusColor}
	on:fieldFocus={(event) => (focusedInputIndex = event.detail)}
	on:fieldUnfocus={() => setTimeout(() => (focusedInputIndex = null), 200)}
	on:keyPress={(event) => handleKeyPress(event.detail.event, event.detail.row, event.detail.column)}
/>
