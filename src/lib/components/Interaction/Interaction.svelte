<script lang="ts">
	import type { Player } from '$lib/data/Player';
	import type { PlayerScore } from '$lib/data/PlayerScore';
	import Letter from '../Letter.svelte';
	import { createEventDispatcher } from 'svelte';
	import PlayerScoreChip from '../PlayerScoreChip.svelte';

	export let color: string;
	export let playersList: Player[];
	export let currentPlayer: Player;
	export let playerScores: PlayerScore[];

	const dispatch = createEventDispatcher<{
		showPlayerScoreDetails: { player: Player; score: PlayerScore };
		preferenceClicked: void;
	}>();
</script>

<div class="interaction-area global-container-bg">
	<div class="letters-container">
		{#each 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('') as value}
			<Letter {value} {color} />
		{/each}
	</div>
	<div class="gap-0.5 large:gap-2 flex flex-col">
		<div class="scoreboard-container">
			{#each playerScores as score}
				<PlayerScoreChip
					player={playersList[score.playerId]}
					myTurn={playersList[score.playerId] == currentPlayer}
					playerScore={score}
					on:onPlayerClick={() =>
						dispatch('showPlayerScoreDetails', {
							player: playersList[score.playerId],
							score: score
						})}
				/>
			{/each}
		</div>

		<div class="flex justify-between w-full">
			<a
				href="https://khaled.is-a.dev"
				target="_blank"
				title="Visit my portfolio"
				class="text-platinum-200 dark:text-glaucous-500">© Khaled</a
			>
			<button
				title="Open game preference panel"
				class="text-platinum-200 dark:text-glaucous-500"
				on:click={() => dispatch('preferenceClicked')}>Preference</button
			>
		</div>
	</div>
</div>

<style lang="postcss">
	.interaction-area {
		@apply h-full p-2 large:p-4;
		@apply flex flex-col justify-between;
		@apply rounded-2xl border-2;
		@apply border-gray-300 dark:border-gray-700;
	}

	.letters-container,
	.scoreboard-container {
		@apply flex flex-wrap gap-1;
	}
</style>
