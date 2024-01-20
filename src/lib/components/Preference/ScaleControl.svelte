<script lang="ts">
	import { createEventDispatcher } from 'svelte';

	const dispatch = createEventDispatcher<{ scaleUpdate: number; centerBoard: void }>();

	let scale = 5;
	const scaleMap: Record<number, number> = {
		1: 0.5,
		2: 0.6,
		3: 0.75,
		4: 0.9,
		5: 1,
		6: 1.1,
		7: 1.2,
		8: 1.3,
		9: 1.5
	};

	$: scale && dispatch('scaleUpdate', scaleMap[scale]);
</script>

<div class="global-field p-1.5 flex items-center large:flex-row flex-col">
	Board Scale
	<div class="flex items-center">
		<button
			class="ml-2 px-2 py-1 rounded-lg global-container-bg"
			on:click={() => (scale = Math.max(scale - 1, 1))}
		>
			-
		</button>
		<span class="p-4">{scale}</span>
		<button
			class="px-2 py-1 rounded-lg global-container-bg"
			on:click={() => (scale = Math.min(scale + 1, 9))}
		>
			+
		</button>
		<div class="h-6 w-0.5 global-container-bg ml-2" />
		<button
			on:click={() => (scale = 5)}
			class="ml-2 global-container-bg font-medium rounded-lg text-sm pr-1 py-0.5 text-center inline-flex items-center"
		>
			<svg
				class="p-0.5 h-6 w-6 large:h-8 large:w-8"
				viewBox="0 0 21 21"
				xmlns="http://www.w3.org/2000/svg"
				><g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
					<path d="M4 6a8 8 0 1 1-1 5" />
					<path d="M8 7H4V3" />
				</g>
			</svg>
		</button>
	</div>

	<div class="large:ml-auto w-fit">
		<button
			on:click={() => dispatch('centerBoard')}
			class="global-container-bg font-medium rounded-lg text-sm pr-1 py-0.5 text-center inline-flex items-center"
			><svg
				class="p-0.5 h-6 w-6 large:h-8 large:w-8 fill-current"
				viewBox="0 0 32 32"
				xmlns="http://www.w3.org/2000/svg"
				><path
					d="M6 12H4V4h8v2H6v6zM28 12h-2V6h-6V4h8v8zM12 28H4v-8h2v6h6v2zM28 28h-8v-2h6v-6h2v8zM15 10h2v4h-2zM10 15h4v2h-4zM18 15h4v2h-4zM15 18h2v4h-2z"
				/></svg
			>Recenter
		</button>
	</div>
</div>
