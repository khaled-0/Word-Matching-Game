<script lang="ts">
	// import { createEventDispatcher } from 'svelte';
	export let dialog: HTMLDialogElement;

	import type { Player } from '$lib/data/Player';
	import type { PlayerScore } from '$lib/data/PlayerScore';

	export let player: Player | undefined;
	export let playerScore: PlayerScore | undefined;
	// const dispatch = createEventDispatcher<{}>();
</script>

<!-- https://svelte.dev/repl/885653f873284f7880490dcdd1200238?version=3.48.0 -->

<dialog bind:this={dialog} class="global-container-bg">
	<div class="title">
		<span>Player Details</span>
		<button class="rounded-xl h-5 w-5 bg-red-600" on:click={() => dialog.close()} />
	</div>

	<div class="body">
		<div class="global-field flex items-center justify-between">
			<span>
				Name: {player?.name}
			</span>
			<div class="h-4 w-4 rounded-md border-1" style="background-color: {player?.color};" />
		</div>
		<div class="global-field">
			Score: {playerScore?.score}
		</div>
		{#if playerScore?.words.length}
			<div class="global-field">
				<label for="message" class="block mb-2"
					>Words <span class="float-end">({playerScore.words.length})</span></label
				>
				<textarea
					readonly
					rows="4"
					value={playerScore.words.map((w) => `${w}(${w.length})`).join(', ')}
					class="p-2 w-full rounded-lg global-container-bg outline-none resize-none"
				/>
			</div>
		{/if}
	</div>
</dialog>

<style lang="postcss">
	dialog {
		@apply w-9/12 large:w-5/12 h-5/6 large:h-3/6;
		@apply p-4 rounded-xl;
		@apply dark:text-platinum-800 text-rich_black-100;
	}

	.title {
		@apply text-xl;
		@apply flex gap-4 justify-between items-center;
	}

	.body {
		@apply p-2 my-2 rounded-xl;
		@apply text-sm font-medium;
	}
	.global-field {
		@apply p-2;
	}
</style>
