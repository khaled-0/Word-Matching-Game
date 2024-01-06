import Trie from '$lib/data/Trie';
import WordsList from '$lib/data/WordsList.json';

const wordsTrie = new Trie();
console.time('wordsLoadInMemory');
for (const word of Object.values(WordsList)) wordsTrie.insert(word);
console.timeEnd('wordsLoadInMemory');
console.log('Loaded', Object.values(WordsList).length, 'words');

export default function isEnglishWord(str: string | null): boolean {
	if (!str) return false;
	return wordsTrie.contains(str);
}
