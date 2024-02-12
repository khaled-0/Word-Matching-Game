<script lang="ts">
	import type { Player } from '$lib/data/Player';
	import type { PlayerScore } from '$lib/data/PlayerScore';

	export let dialog: HTMLDialogElement;
	export let player: Player | undefined;
	export let playerScore: PlayerScore | undefined;
</script>

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
				<label for="wordslist" class="block mb-2"
					>Words <span class="float-end">({playerScore.words.length})</span></label
				>
				<div class="words-container">
					{#each playerScore.words as word}
						<p>{word}({word.length})</p>
					{/each}
				</div>
			</div>
		{/if}
	</div>
</dialog>

<style lang="postcss">
	dialog {
		@apply w-9/12 large:w-5/12 h-3/5;
		@apply p-4 rounded-xl;
		@apply dark:text-gray-300 text-gray-800;
	}

	.title {
		@apply text-xl;
		@apply flex gap-4 justify-between items-center;
	}

	.body {
		@apply p-2 mt-2 rounded-xl;
	}
	.global-field {
		@apply p-2;
	}

	.words-container {
		@apply p-2 w-full rounded-lg global-container-bg outline-none resize-none;
	}
</style>
