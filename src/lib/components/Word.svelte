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

<button on:click={dispatchClick} class=" p-2 border-2 border-black rounded m-2">{value}</button>
