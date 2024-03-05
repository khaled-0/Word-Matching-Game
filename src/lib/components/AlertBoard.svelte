<script lang="ts">
	import type { AlertMessages, AlertMessage } from '$lib/data/AlertBoard';
	import { Toast } from 'flowbite-svelte';
	export let alertMessages: AlertMessages;

	function addToDismissQueue(alert: AlertMessage) {
		setTimeout(() => (alertMessages = alertMessages.filter((e) => e != alert)), 5000);
	}
</script>

{#each alertMessages as alert}
	<Toast class="relative mx-0.5 my-1 p-0.5 large:p-1 w-fit gap-0">
		<div class="flex items-center mx-0.5 large:mx-1">
			<span class="color" style="--color:{alert.color}"></span>
			<div class="ms-2 flex gap-2">
				<div class="text-sm large:text-xl font-semibold text-gray-900 dark:text-white">
					{alert.title}
				</div>
				<div class="text-sm large:text-lg font-normal">{alert.message}</div>
			</div>
		</div>
		<template slot="close-button"> {addToDismissQueue(alert)}</template>
	</Toast>
{/each}

<style lang="postcss">
	.color {
		@apply h-4 w-4 large:h-6 large:w-6;
		@apply rounded-full flex-shrink-0;
		background-color: var(--color);
	}
</style>
