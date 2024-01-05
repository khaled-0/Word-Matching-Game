import stringReverse from './stringReverse';

/**
 * @param submitRow Player's input row index
 * @param submitColumn Player's input column index
 * @returns a word with atleast 2 letters in the vertical input column, otherwise null
 */
export default async function getVerticalWord(
	boardData: HTMLInputElement[][],
	submitRow: number,
	submitColumn: number
): Promise<string | null> {
	const inputWord: string = boardData[submitRow][submitColumn].value;
	const columnLength = boardData.length;

	//Bottom letters till blank field
	let bottomWord = '';
	for (let i = submitRow + 1; i < columnLength; i++) {
		if (boardData[i][submitColumn].value.length == 0) break;
		bottomWord += boardData[i][submitColumn].value;
	}

	// Top letters till blank field
	let topWord = '';
	for (let i = submitRow - 1; i >= 0; i--) {
		if (boardData[i][submitColumn].value.length == 0) break;
		topWord += boardData[i][submitColumn].value;
	}

	if (topWord.length == 0 && bottomWord.length == 0) return null;

	const verticalWord = stringReverse(topWord) + inputWord + bottomWord;
	return verticalWord;
}
