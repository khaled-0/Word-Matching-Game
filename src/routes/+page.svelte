<script>
	import Board from '$lib/components/Board/Board.svelte';
	import Letter from '$lib/components/Letter.svelte';
	import { playersList } from '$lib/data/Player';

	let color = playersList[0].color;
</script>

<div class="">
	{#each 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('') as value}
		<Letter {value} {color} />
	{/each}
</div>

<Board
	boardSize={10}
	playerCount={4}
	on:onPlayerSubmit={(event) => {
		event.detail.nextPlayerId;
		color = playersList[event.detail.nextPlayerId].color;
	}}
/>
