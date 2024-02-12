<script lang="ts">
	import type { Player } from '$lib/data/Player';
	import type { PlayerScore } from '$lib/data/PlayerScore';
	import { Modal } from 'flowbite-svelte';

	export let open: boolean;
	export let player: Player | undefined;
	export let playerScore: PlayerScore | undefined;
</script>

<Modal class="divide-none" size="sm" bind:open title="Player Details">
	<div>
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
</Modal>

<style lang="postcss">
	.global-field {
		@apply p-2;
	}

	.words-container {
		@apply p-2 w-full rounded-lg outline-none resize-none;
		@apply bg-gray-200 dark:bg-gray-900;
	}
</style>
