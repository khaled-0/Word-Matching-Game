// Trie.js - super simple JS implementation
// https://en.wikipedia.org/wiki/Trie
// Author: https://gist.github.com/tpae/72e1c54471e88b689f85ad2b3940a8f0
// Alternated for specific need
// -----------------------------------------

// we start with the TrieNode
class TrieNode {
	public parent?: TrieNode; // we keep a reference to parent
	public children: { [key: string]: TrieNode } = {}; // we have hash of children
	public end = false; // check to see if the node is at the end
}

// -----------------------------------------

// we implement Trie with just a simple root with null value.
class Trie {
	private root: TrieNode;

	constructor() {
		this.root = new TrieNode();
	}

	// inserts a word into the trie.
	// time complexity: O(k), k = word length
	insert(word: string) {
		let node = this.root; // we start at the root 😬

		// for every character in the word
		for (let i = 0; i < word.length; i++) {
			// check to see if character node exists in children.
			if (!node.children[word[i]]) {
				// if it doesn't exist, we then create it.
				node.children[word[i]] = new TrieNode();

				// we also assign the parent to the child node.
				node.children[word[i]].parent = node;
			}

			// proceed to the next depth in the trie.
			node = node.children[word[i]];

			// finally, we check to see if it's the last word.
			if (i == word.length - 1) {
				// if it is, we set the end flag to true.
				node.end = true;
			}
		}
	}

	// check if it contains a whole word.
	// time complexity: O(k), k = word length
	contains(word: string): boolean {
		let node = this.root;

		// for every character in the word
		for (let i = 0; i < word.length; i++) {
			// check to see if character node exists in children.
			if (node.children[word[i]]) {
				// if it exists, proceed to the next depth of the trie.
				node = node.children[word[i]];
			} else {
				// doesn't exist, return false since it's not a valid word.
				return false;
			}
		}

		// we finished going through all the words, but is it a whole word?
		return node.end;
	}
}

export default Trie;
