import type { BoardSize, PlayerCount } from './Board';

export type GameParameter = {
	board: BoardSize;
	players: PlayerCount;
	names?: Array<string>;
	colors?: Array<string>;
};
