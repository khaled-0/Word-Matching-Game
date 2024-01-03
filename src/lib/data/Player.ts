export type Player = {
	name: string;
	id: 0 | 1 | 2 | 3;
	color: string;
};

export const PlayersList: Array<Player> = [
	{ name: 'P1', id: 0, color: 'red' },
	{ name: 'P2', id: 1, color: 'green' },
	{ name: 'P3', id: 2, color: 'blue' },
	{ name: 'P4', id: 3, color: 'yellow' }
];
