// Reverses a string. Unicode Aware
// https://stackoverflow.com/a/959004/16867144
export default function (string: string): string {
	return [...string].reverse().join('');
}
