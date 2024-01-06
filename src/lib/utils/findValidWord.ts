import isEnglishWord from './isWord';

export default async function findValidWord(
	word: string | null,
	playerInput: string,
	existingWords: string[]
): Promise<string | null> {
	if (!word) return null;
	word = word.toLowerCase();
	playerInput = playerInput.toLowerCase();

	let largestUniqueWord = '';
	for (let i = 0; i < word.length; i++) {
		for (let j = i + 1; j <= word.length; j++) {
			const currentWord = word.substring(i, j);

			// Ignore small words
			if (currentWord.length <= 2) continue;
			if (currentWord.length < largestUniqueWord.length) continue;
			// The word must include the player's input char
			if (!currentWord.includes(playerInput)) continue;
			// Scored words must be unique
			if (existingWords.includes(currentWord)) continue;
			// Word must be an english word
			if (!isEnglishWord(currentWord)) continue;

			largestUniqueWord = currentWord;
		}
	}

	if (largestUniqueWord.length != 0) return largestUniqueWord;
	return null;
}
