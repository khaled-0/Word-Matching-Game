export type PlayerCount = 2 | 3 | 4 | 5 | 6;
export type BoardSize = 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16;

export type GameParameter = {
	board: BoardSize;
	players: PlayerCount;
	names?: Array<string>;
	colors?: Array<string>;
};
