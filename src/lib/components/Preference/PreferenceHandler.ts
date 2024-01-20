export function centerBoard(element: HTMLElement | null) {
	if (element == null) return;
	element.style.top = '';
	element.style.bottom = '';
	element.style.left = '';
	element.style.right = '';
}
