<script lang="ts">
	export let boardData: HTMLInputElement[][];
	export let placeholder: boolean;

	import { createEventDispatcher } from 'svelte';
	const dispatch = createEventDispatcher<{
		keyPress: { event: KeyboardEvent; row: number; column: number };
		fieldFocus: { row: number; column: number };
		fieldUnfocus: null;
	}>();
	function handleKeyPressValidation(keyPress: KeyboardEvent, row: number, column: number) {
		dispatch('keyPress', {
			event: keyPress,
			row: row,
			column: column
		});
	}
</script>

<div class="rows-container" style="--row:{boardData.length}">
	{#each boardData as row, rowIndex}
		<div class="row">
			{#each row as columnField, columnIndex}
				<input
					placeholder={placeholder
						? (columnIndex + rowIndex * boardData[0].length).toString()
						: null}
					class="input"
					maxlength="1"
					type="text"
					bind:this={columnField}
					on:focus={() => {
						dispatch('fieldFocus', { row: rowIndex, column: columnIndex });
					}}
					on:keydown|preventDefault={(e) => handleKeyPressValidation(e, rowIndex, columnIndex)}
				/>
			{/each}
		</div>
	{/each}
</div>

<style lang="postcss">
	.rows-container {
		@apply gap-1 h-fit w-fit;
		display: grid;
		grid-template-rows: repeat(var(--row), 1fr);
		width: fit-content;
	}

	.row {
		@apply w-full flex gap-1;
	}

	.input {
		@apply p-0 medium:p-1 large:p-2;
		@apply w-6 medium:w-10 large:w-14;
		@apply h-6 medium:h-10 large:h-14;

		@apply text-center cursor-pointer caret-transparent;
		@apply text-xs medium:text-xl large:text-2xl;

		@apply bg-glaucous-100 rounded-md;
		color: var(--color);

		@apply focus-visible:bg-powder_blue-100;
	}
</style>
