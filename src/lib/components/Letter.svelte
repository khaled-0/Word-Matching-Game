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
		@apply p-2 border-2 border-black rounded;
		background-color: var(--color);
		color: white;
	}
</style>
