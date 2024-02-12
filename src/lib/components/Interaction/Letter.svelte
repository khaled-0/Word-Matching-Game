<script lang="ts">
	export let value: string;

	function dispatchClick() {
		document.dispatchEvent(
			new KeyboardEvent('keypress', {
				key: value
			})
		);
	}
</script>

<button title={`Insert ${value} on selected field`} on:click={dispatchClick}>{value}</button>

<style lang="postcss">
	button {
		@apply w-8 h-8 large:w-12 large:h-12 flex-1 basis-auto;
		@apply text-xs font-semibold;

		@apply text-gray-800 bg-gray-100 border border-gray-200 rounded-lg;
		@apply dark:bg-gray-600 dark:text-gray-200 dark:border-gray-500;
	}
</style>
