<script lang="ts">
	import { P, Toggle } from 'flowbite-svelte';

	export let title: string;
	export let checked: boolean;
</script>

<div class="global-field p-2 flex items-center justify-between">
	<P>{title}</P>
	<Toggle size="large" bind:checked />
</div>
