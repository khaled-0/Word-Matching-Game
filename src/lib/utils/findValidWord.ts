export default async function findValidWord(word: string | null): Promise<string | null> {
	if (!word) return null;
	if (word.length == 2) return null;

	word = word.toLowerCase();

	if (['sus', 'nub'].includes(word)) return word;
	return null;
}
