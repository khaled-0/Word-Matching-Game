import type { GameParameter, BoardSize, PlayerCount } from '$lib/data/GameParameters';
import type { PageLoad } from './$types';

export const load = (async ({ url }) => {
	return {
		board: Math.min(parseInt(url.searchParams.get('board')!) || 10, 16) as BoardSize,
		players: Math.min(parseInt(url.searchParams.get('players')!) || 4, 6) as PlayerCount, //todoo limit err
		colors: url.searchParams.get('colors')?.split(','),
		names: url.searchParams.get('names')?.split(',')
	} satisfies GameParameter;
}) satisfies PageLoad;
