<script lang="ts">
	export let boardData: HTMLInputElement[][];

	import { createEventDispatcher } from 'svelte';
	const dispatch = createEventDispatcher<{
		keyPress: { event: KeyboardEvent; row: number; column: number };
		fieldFocus: { row: number; column: number };
	}>();
	function handleKeyPressValidation(keyPress: KeyboardEvent, row: number, column: number) {
		dispatch('keyPress', {
			event: keyPress,
			row: row,
			column: column
		});
	}
</script>

{#each boardData as row, rowIndex}
	<div class="board">
		{#each row as columnField, columnIndex}
			<span class="column">
				<input
					placeholder={(columnIndex + rowIndex * boardData[0].length).toString()}
					class="input"
					maxlength="1"
					type="text"
					bind:this={columnField}
					on:focus={() => dispatch('fieldFocus', { row: rowIndex, column: columnIndex })}
					on:keydown|preventDefault={(e) => handleKeyPressValidation(e, rowIndex, columnIndex)}
				/>
			</span>
		{/each}
	</div>
{/each}

<style lang="postcss">
	.input {
		@apply w-16 h-16 m-2 bg-gray-600 text-center;
		color: var(--color);
	}

	.board {
		@apply mx-auto w-fit;
	}
</style>
