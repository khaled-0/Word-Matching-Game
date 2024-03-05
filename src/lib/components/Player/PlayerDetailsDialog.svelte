<script lang="ts">
	import type { Player } from '$lib/data/Player';
	import type { PlayerScore } from '$lib/data/PlayerScore';
	import { Badge, Modal, P } from 'flowbite-svelte';

	export let open: boolean;
	export let player: Player | undefined;
	export let playerScore: PlayerScore | undefined;
</script>

<Modal class="divide-none" size="sm" bind:open title="Player Details">
	<div>
		<div class="global-field flex items-center justify-between">
			<P>
				Name: {player?.name}
			</P>
			<div class="h-4 w-4 rounded-md border-1" style="background-color: {player?.color};" />
		</div>
		<div class="global-field">
			<P>Score: {playerScore?.score}</P>
		</div>
		{#if playerScore?.words.length}
			<div class="global-field">
				<P class="block mb-2">Words <P class="float-end">({playerScore.words.length})</P></P>
				<div class="words-container">
					{#each playerScore.words as word}
						<Badge large class="m-0.5 pr-0 py-0">
							{word}
							<Badge
								class="p-1 pb-0.5 ml-1 font-bold rounded-l-none bg-primary-50 dark:bg-primary-950"
								>{word.length}</Badge
							>
						</Badge>
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
