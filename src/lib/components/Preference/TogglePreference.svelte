<script lang="ts">
	import Switch from '../Switch.svelte';

	export let title: string;
	export let checked: boolean;
</script>

<div class="global-field p-2 flex items-center justify-between">
	{title}
	<Switch bind:checked />
</div>
