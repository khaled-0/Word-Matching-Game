<script lang="ts">
	import type { Player } from '$lib/data/Player';
	import type { PlayerScore } from '$lib/data/PlayerScore';
	import Letter from './Letter.svelte';
	import { createEventDispatcher } from 'svelte';
	import PlayerScoreChip from '../Player/PlayerScoreChip.svelte';
	import PlayerDetailsDialog from '../Player/PlayerDetailsDialog.svelte';
	import { Card } from 'flowbite-svelte';

	export let playersList: Player[];
	export let currentPlayer: Player;
	export let playerScores: PlayerScore[];

	let playerDetailsDialog: HTMLDialogElement;
	let playerDetailsDialogData: { player: Player; score: PlayerScore };
	const dispatch = createEventDispatcher<{
		preferenceClicked: void;
	}>();
</script>

<Card class="h-full p-2 large:p-4 justify-between" size="xl">
	<div class="flex flex-wrap gap-1">
		{#each 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('') as value}
			<Letter {value} />
		{/each}
	</div>
	<div class="gap-0.5 large:gap-2 flex flex-col">
		<div class="flex flex-wrap gap-1">
			{#each playerScores as score}
				<PlayerScoreChip
					player={playersList[score.playerId]}
					myTurn={playersList[score.playerId] == currentPlayer}
					playerScore={score}
					on:onPlayerClick={() => {
						playerDetailsDialogData = { player: playersList[score.playerId], score: score };
						playerDetailsDialog.showModal();
					}}
				/>
			{/each}
		</div>

		<div class="flex justify-between w-full">
			<a
				href="https://khaled.is-a.dev"
				target="_blank"
				title="Visit my portfolio"
				class="text-primary-700">© Khaled</a
			>
			<button
				title="Open game preference panel"
				class="text-primary-700"
				on:click={() => dispatch('preferenceClicked')}>Preference</button
			>
		</div>
	</div>
</Card>

<PlayerDetailsDialog
	bind:dialog={playerDetailsDialog}
	player={playerDetailsDialogData?.player}
	playerScore={playerDetailsDialogData?.score}
/>
