<script lang="ts">
	export let boardData: HTMLInputElement[][];
	export let boardHint: boolean;
	export let focusColor: string;

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

<div class="rows-container" style="--row:{boardData.length}; --focusColor:{focusColor}">
	{#each boardData as row, rowIndex}
		<div class="row">
			{#each row as columnField, columnIndex}
				<input
					class="input"
					maxlength="1"
					type="text"
					inputmode="none"
					name="{rowIndex}:{columnIndex}"
					bind:this={columnField}
					on:focus={() => dispatch('fieldFocus', { row: rowIndex, column: columnIndex })}
					on:focusout={() => dispatch('fieldUnfocus')}
					on:keydown|preventDefault={(e) => handleKeyPressValidation(e, rowIndex, columnIndex)}
					placeholder={boardHint ? (columnIndex + rowIndex * boardData[0].length).toString() : null}
				/>
			{/each}
		</div>
	{/each}
</div>

<style lang="postcss">
	.rows-container {
		@apply grid gap-1 h-fit w-fit;
		grid-template-rows: repeat(var(--row), 1fr);
	}

	.row {
		@apply w-full flex gap-1;
	}

	.input {
		@apply p-0 large:p-2;
		@apply w-10 large:w-14;
		@apply h-10 large:h-14;

		@apply text-center cursor-pointer caret-transparent;
		@apply text-xl large:text-2xl;

		@apply rounded-md outline-none border-none ring-0;
		color: var(--color);

		@apply bg-slate-200 dark:bg-gray-800;
		@apply focus-visible:bg-slate-100 dark:focus-visible:bg-gray-700;
	}

	.input:focus {
		outline-color: var(--focusColor);
	}

	.input:disabled {
		pointer-events: none;
		animation: popout 300ms;
	}

	@keyframes popout {
		from {
			transform: scale(0);
		}
		80% {
			transform: scale(1.2);
		}
		to {
			transform: scale(1);
		}
	}
</style>
