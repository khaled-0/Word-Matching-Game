<script lang="ts">
	import PlayerSelection from '$lib/components/Player/PlayerSelection.svelte';
	import RangeSlider from '$lib/components/RangeSlider.svelte';
	import type { GameParameter } from '$lib/data/GameParameters';
	import { PlayersList } from '$lib/data/Player';
	import { Label, Button, Card, Spinner } from 'flowbite-svelte';

	let gameParams: GameParameter = {
		board: 10,
		players: 3,
		colors: [],
		names: []
	};

	const playersList = Array.from(PlayersList);
	let loadingState = false;

	function launchGame() {
		loadingState = true;
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
		loadingState = false;
	}
</script>

<div class="p-4 h-svh flex justify-center">
	<Card size="xl" class=" large:w-3/6 items-center">
		<h1 class="text-2xl w-fit my-2 text-center">Epic Word Matching Game</h1>
		<div class="mb-4" />

		<Label defaultClass="w-full mb-1"
			>Board Size<span class="float-end">{gameParams.board}</span></Label
		>
		<RangeSlider size="lg" min={6} max={16} bind:value={gameParams.board} />
		<div class="mb-4" />

		<Label defaultClass="w-full mb-1"
			>Players<span class="float-end">{gameParams.players}</span></Label
		>
		<RangeSlider size="lg" min={2} max={6} bind:value={gameParams.players} />

		<div class="mb-4" />

		<div class="flex flex-wrap w-full gap-1 justify-center">
			{#each playersList as player, index}
				{#if index < gameParams.players}
					<PlayerSelection bind:player />
				{/if}
			{/each}
		</div>

		<div class="mb-4" />
		{#if loadingState}
			<Spinner />
		{:else}
			<Button on:click={launchGame}>Play</Button>
		{/if}

		<span class="mt-auto">
			Made By <a class="text-primary-700" href="https://khaled.is-a.dev" target="_blank">Khaled</a>
			&#10084;
			<a class="text-orange-500" href="https://kit.svelte.dev">SvelteKit</a>
		</span>
		<span
			><a class="text-primary-700" href="https://words.fr.to" target="_blank">words.fr.to</a>
			is provided by
			<a class="text-primary-700" href="https://freedns.afraid.org" target="_blank">afraid.org</a
			></span
		>
	</Card>
</div>
