export type Player = {
	name: string;
	id: 0 | 1 | 2 | 3 | 4 | 5 | 6;
	color: string;
};

export const PlayersList: Array<Player> = [
	{ name: 'P1', id: 0, color: '#e32146' },
	{ name: 'P2', id: 1, color: '#22aa24' },
	{ name: 'P3', id: 2, color: '#3584e4' },
	{ name: 'P4', id: 3, color: '#c16a26' },
	{ name: 'P5', id: 4, color: '#f83c00' },
	{ name: 'P6', id: 5, color: '#1b1d1e' }
];
