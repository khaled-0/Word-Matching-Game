<script lang="ts">
	import { Range, Button } from 'flowbite-svelte';
	export let size: 'sm' | 'lg' | 'md' | undefined, min: number, max: number, value: number;
</script>

<div class="flex w-full items-center gap-2">
	<Button outline class="ml-2 p-0.5" on:click={() => (value = Math.max(value - 1, min))}>
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
	<Range {size} {min} {max} bind:value />
	<Button outline class="p-0.5" on:click={() => (value = Math.min(value + 1, max))}>
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
</div>
