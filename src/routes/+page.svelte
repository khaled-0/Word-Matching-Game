<script lang="ts">
	import PlayerSelection from '$lib/components/Player/PlayerSelection.svelte';
	import type { GameParameter } from '$lib/data/GameParameters';
	import { PlayersList } from '$lib/data/Player';
	import { Range, Label, Button, Card } from 'flowbite-svelte';

	let gameParams: GameParameter = {
		board: 10,
		players: 3,
		colors: [],
		names: []
	};

	const playersList = Array.from(PlayersList);

	function launchGame() {
		let gameUrl = `./game?players=${gameParams.players}&board=${gameParams.board}`;

		gameParams.names = playersList
			.slice(0, gameParams.players)
			.map((p) => encodeURIComponent(p.name));
		gameParams.colors = playersList
			.slice(0, gameParams.players)
			.map((p) => encodeURIComponent(p.color));

		if (gameParams.names?.length) gameUrl += `&names=${gameParams.names.join(',')}`;
		if (gameParams.colors?.length) gameUrl += `&colors=${gameParams.colors.join(',')}`;

		window.location.href = gameUrl;
	}
</script>

<div class="p-4 h-svh flex justify-center">
	<Card size="xl" class=" large:w-3/6 items-center">
		<h1 class="text-2xl w-fit my-2">Epic Word Matching Game</h1>
		<div class="mb-4" />

		<Label defaultClass="w-full mb-1"
			>Board Size<span class="float-end">{gameParams.board}</span></Label
		>
		<Range size="lg" min="6" max="16" bind:value={gameParams.board} />
		<div class="mb-4" />

		<Label defaultClass="w-full mb-1"
			>Players<span class="float-end">{gameParams.players}</span></Label
		>
		<Range size="lg" min="2" max="6" bind:value={gameParams.players} />
		<div class="mb-4" />

		<div class="flex flex-wrap w-full gap-1 justify-center">
			{#each playersList as player, index}
				{#if index < gameParams.players}
					<PlayerSelection bind:player />
				{/if}
			{/each}
		</div>

		<div class="mb-4" />
		<Button on:click={launchGame}>Play</Button>

		<span class="mt-auto">
			Made By <a class="text-primary-700" href="https://khaled.is-a.dev" target="_blank">Khaled</a>
			&#10084;
			<a class="text-orange-500" href="https://kit.svelte.dev">SvelteKit</a>
		</span>
	</Card>
</div>
