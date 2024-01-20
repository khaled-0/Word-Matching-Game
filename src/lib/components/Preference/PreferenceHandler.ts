export function centerBoard(element: HTMLElement | null) {
	if (element == null) return;
	const transitionBackup = element.style.transition;
	element.style.transition += 'all 0.15s cubic-bezier(0.4, 0, 0.2, 1)';
	element.style.top = '';
	element.style.bottom = '';
	element.style.left = '';
	element.style.right = '';
	setTimeout(() => (element.style.transition = transitionBackup), 150);
}
