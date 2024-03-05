<script lang="ts">
	import { Button, P } from 'flowbite-svelte';
	import { createEventDispatcher } from 'svelte';

	const dispatch = createEventDispatcher<{ scaleUpdate: number; centerBoard: void }>();
	export let scale: number;
</script>

<div class="global-field p-1.5 flex items-center large:flex-row flex-col">
	<P>Board Scale</P>
	<div class="flex items-center">
		<Button
			outline
			class="ml-2 p-0.5"
			on:click={() => (scale = Number(Math.max(scale - 0.1, 0.7).toFixed(1)))}
		>
			<svg
				class="w-6 h-6"
				aria-hidden="true"
				xmlns="http://www.w3.org/2000/svg"
				fill="none"
				viewBox="0 0 24 24"
			>
				<path
					stroke="currentColor"
					stroke-linecap="round"
					stroke-linejoin="round"
					stroke-width="2"
					d="M5 12h14"
				/>
			</svg>
		</Button>
		<span class="p-4">{scale}</span>
		<Button
			outline
			class="p-0.5"
			on:click={() => (scale = Number(Math.min(scale + 0.1, 1.5).toFixed(1)))}
		>
			<svg
				class="w-6 h-6"
				aria-hidden="true"
				xmlns="http://www.w3.org/2000/svg"
				fill="none"
				viewBox="0 0 24 24"
			>
				<path
					stroke="currentColor"
					stroke-linecap="round"
					stroke-linejoin="round"
					stroke-width="2"
					d="M5 12h14m-7 7V5"
				/>
			</svg>
		</Button>

		<div class="h-6 w-0.5 ml-2 bg-gray-300 dark:bg-slate-700" />

		<Button outline on:click={() => (scale = 1)} class="ml-2 p-1">
			<svg
				class="w-6 h-6"
				aria-hidden="true"
				xmlns="http://www.w3.org/2000/svg"
				fill="none"
				viewBox="0 0 24 24"
			>
				<path
					stroke="currentColor"
					stroke-linecap="round"
					stroke-linejoin="round"
					stroke-width="2"
					d="M17.7 7.7A7.1 7.1 0 0 0 5 10.8M18 4v4h-4m-7.7 8.3A7.1 7.1 0 0 0 19 13.2M6 20v-4h4"
				/>
			</svg>
		</Button>
	</div>

	<div class="large:ml-auto w-fit">
		<Button outline pill size="sm" on:click={() => dispatch('centerBoard')}
			><svg
				class="w-6 h-6"
				aria-hidden="true"
				xmlns="http://www.w3.org/2000/svg"
				fill="none"
				viewBox="0 0 24 24"
			>
				<path
					stroke="currentColor"
					stroke-linecap="round"
					stroke-linejoin="round"
					stroke-width="2"
					d="M5 9h4m0 0V5m0 4L4 4m15 5h-4m0 0V5m0 4 5-5M5 15h4m0 0v4m0-4-5 5m15-5h-4m0 0v4m0-4 5 5"
				/>
			</svg>Recenter
		</Button>
	</div>
</div>
