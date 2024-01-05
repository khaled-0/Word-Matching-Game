import getHorizontalWord from '$lib/utils/getHorizontalWord';
import getVerticalWord from '$lib/utils/getVerticalWord';
import findValidWord from '$lib/utils/findValidWord';

export type PlayerScore = {
	playerId: number;
	score: number;
	words: string[];
};

export async function calculateInputScore(
	boardData: HTMLInputElement[][],
	submitRow: number,
	submitColumn: number
): Promise<{ words: string[]; score: number }> {
	const [horizontalWord, verticalWord] = await Promise.all([
		getHorizontalWord(boardData, submitRow, submitColumn),
		getVerticalWord(boardData, submitRow, submitColumn)
	]);

	const [horizontalValidWord, verticalValidWord] = await Promise.all([
		findValidWord(horizontalWord),
		findValidWord(verticalWord)
	]);

	const words = [];
	let score = 0;
	if (horizontalValidWord) {
		words.push(horizontalValidWord);
		score += horizontalValidWord.length;
	}
	if (verticalValidWord) {
		words.push(verticalValidWord);
		score += verticalValidWord.length;
	}

	return { words: words, score: score };
}
