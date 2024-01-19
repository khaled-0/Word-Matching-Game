import type { BoardSize, PlayerCount } from '$lib/data/Board';
import type { GameParameter } from '$lib/data/GameParameters';
import type { PageLoad } from './$types';

export const load = (async ({ url }) => {
	return {
		board: (parseInt(url.searchParams.get('board')!) || 10) as BoardSize,
		players: (parseInt(url.searchParams.get('players')!) || 4) as PlayerCount, //todoo limit err
		colors: url.searchParams.get('colors')?.split(','),
		names: url.searchParams.get('names')?.split(',')
	} satisfies GameParameter;
}) satisfies PageLoad;
