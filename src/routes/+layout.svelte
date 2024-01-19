<script>
	import '../app.css';
	import { navigating } from '$app/stores';
	import Spinner from '$lib/components/Spinner.svelte';
</script>

{#if $navigating}
	<div class="flex justify-center items-center absolute bottom-0 top-0 left-0 right-0">
		<Spinner />
	</div>
{:else}
	<slot />
{/if}
