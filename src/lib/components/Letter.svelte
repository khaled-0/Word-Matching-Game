<script lang="ts">
	export let value: string;
	export let color: 'red' | 'green' | 'blue' | 'yellow' | string;

	function dispatchClick() {
		document.dispatchEvent(
			new KeyboardEvent('keypress', {
				key: value
			})
		);
	}
</script>

<button on:click={dispatchClick} style={`--color:${color}`}>{value}</button>

<style lang="postcss">
	button {
		@apply large:p-2 border rounded-lg;
		@apply w-8 h-8 large:w-12 large:h-12;
		@apply flex-1 basis-auto text-platinum-800;

		@apply border-gray-300 dark:border-gray-700;

		background-color: var(--color);
	}
</style>
