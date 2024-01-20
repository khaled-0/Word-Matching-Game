<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	import Preference from './Preference.svelte';
	export let dialog: HTMLDialogElement;

	const dispatch = createEventDispatcher<{
		centerBoard: void;
	}>();
</script>

<dialog bind:this={dialog} class="global-container-bg">
	<div class="title">
		<span>Preferences</span>
		<button class="rounded-xl h-5 w-5 bg-red-600" on:click={() => dialog.close()} />
	</div>
	<div class="body">
		<Preference title="Board Hint" />
		<div class="global-field p-2">
			<div class="ml-auto w-fit">
				<button
					type="button"
					on:click={() => dispatch('centerBoard')}
					class="global-container-bg active:opacity-80 select-none font-medium rounded-lg text-sm pr-1 py-0.5 text-center inline-flex items-center"
				>
					<svg
						class="h-8 w-8 p-2 fill-current"
						fill="none"
						xmlns="http://www.w3.org/2000/svg"
						viewBox="0 0 122.88 109.78"
						><path
							d="M28.94,13.7l.09-.09,5.65-5.67.15-.13c2.61-2.4,5.24-1.62,6.76,1.44a1.59,1.59,0,0,1,.16.54c1.25,10.35,2.1,20.29,3.34,30.64.25,3.42-2.08,4.84-5.24,4.47l-28.21-3c-4.92-.58-7.36-3.84-3.42-7.78,1.78-1.77,3.54-3.58,5.34-5.32l-13-13a2,2,0,0,1,0-2.8L13,.58a2,2,0,0,1,2.81,0L28.94,13.7Zm32.5,27.58A13.61,13.61,0,1,1,47.83,54.89,13.61,13.61,0,0,1,61.44,41.28Zm32.5,54.8-.09.09-5.66,5.67a.86.86,0,0,1-.14.13c-2.61,2.4-5.24,1.62-6.76-1.44a1.58,1.58,0,0,1-.16-.55C79.88,89.64,79,79.7,77.79,69.35c-.25-3.42,2.07-4.84,5.24-4.47l28.21,3c4.92.58,7.36,3.84,3.42,7.78-1.78,1.77-3.54,3.58-5.34,5.32l13,13a2,2,0,0,1,0,2.8l-12.42,12.43a2,2,0,0,1-2.81,0L93.94,96.08Zm-65,0,.09.09,5.65,5.67.15.13c2.61,2.4,5.24,1.62,6.76-1.44a1.58,1.58,0,0,0,.16-.55C43,89.64,43.85,79.7,45.09,69.35c.25-3.42-2.08-4.84-5.24-4.47l-28.21,3c-4.92.58-7.36,3.84-3.42,7.78C10,77.44,11.76,79.25,13.56,81L.58,94a2,2,0,0,0,0,2.8L13,109.21a2,2,0,0,0,2.81,0L28.94,96.08Zm65-82.38-.09-.09L88.19,7.94a.86.86,0,0,0-.14-.13c-2.61-2.4-5.24-1.62-6.76,1.44a1.59,1.59,0,0,0-.16.54C79.88,20.14,79,30.08,77.79,40.43c-.25,3.42,2.07,4.84,5.24,4.47l28.21-3c4.92-.58,7.36-3.84,3.42-7.78-1.78-1.77-3.54-3.58-5.34-5.32l13-13a2,2,0,0,0,0-2.8L109.88.58a2,2,0,0,0-2.81,0L93.94,13.7Z"
						/></svg
					>
					Recenter
				</button>
			</div>
		</div>
		<Preference title="Board Hint" />
	</div>
</dialog>

<style lang="postcss">
	dialog {
		@apply w-9/12 large:w-5/12 h-4/6;
		@apply p-4 rounded-xl;
		@apply dark:text-platinum-800 text-rich_black-100;
	}

	.title {
		@apply text-xl;
		@apply flex gap-4 justify-between items-center;
	}

	.body {
		@apply p-2 mt-2 rounded-xl;
	}
</style>
