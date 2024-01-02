<script lang="ts">
	import { onMount } from 'svelte';

	export let boardSize: 10 | 15 | 20;

	const words = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
	let boardData: HTMLInputElement[][] = Array.from(Array(boardSize), () =>
		new Array(boardSize).fill('')
	);

	function handleKeyPressValidation(keyPress: KeyboardEvent, row: number, column: number) {
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

			default:
				if (boardData[row][column].value) break;
				if (words.includes(keyPress.key.toUpperCase())) {
					boardData[row][column].value = keyPress.key.toUpperCase();
					boardData[row][column].disabled = true;
					return true;
				}
		}

		return false;
	}

	let focusedInputIndex: { row: number; column: number } | null;
	onMount(() => {
		document.addEventListener('keypress', (event) => {
			if (focusedInputIndex == null) return;
			handleKeyPressValidation(event, focusedInputIndex.row, focusedInputIndex.column);
		});
	});
</script>

{#each boardData as row, rowIndex}
	<div class="board">
		{#each row as columnField, columnIndex}
			<span class="column">
				<input
					placeholder={(columnIndex + rowIndex * 10).toString()}
					class="input"
					maxlength="1"
					type="text"
					bind:this={columnField}
					on:focus={() => (focusedInputIndex = { row: rowIndex, column: columnIndex })}
					on:keydown|preventDefault={(e) => handleKeyPressValidation(e, rowIndex, columnIndex)}
				/>
			</span>
		{/each}
	</div>
{/each}

<style lang="postcss">
	.input {
		@apply w-16 h-16 m-2 bg-gray-600 text-center;
	}

	.board {
		@apply mx-auto w-fit;
	}
</style>
