import stringReverse from './stringReverse';

/**
 * @param submitRow Player's input row index
 * @param submitColumn Player's input column index
 * @returns a word with atleast 2 letters in the horizontal input row, otherwise null
 */
export default async function getHorizontalWord(
	boardData: HTMLInputElement[][],
	submitRow: number,
	submitColumn: number
): Promise<string | null> {
	const inputWord: string = boardData[submitRow][submitColumn].value;
	const rowLength = boardData[0].length;

	//Right letters till blank field
	let rightWord = '';
	for (let i = submitColumn + 1; i < rowLength; i++) {
		if (boardData[submitRow][i].value.length == 0) break;
		rightWord += boardData[submitRow][i].value;
	}

	// Left letters till blank field
	let leftWord = '';
	for (let i = submitColumn - 1; i >= 0; i--) {
		if (boardData[submitRow][i].value.length == 0) break;
		leftWord += boardData[submitRow][i].value;
	}

	if (leftWord.length == 0 && rightWord.length == 0) return null;

	const horizontalWord = stringReverse(leftWord) + inputWord + rightWord;
	return horizontalWord;
}
