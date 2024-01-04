// https://www.w3schools.com/howto/howto_js_draggable.asp
// Expanded upon to work on touch screen
export default function (element: HTMLElement): void {
	let pos1: number = 0,
		pos2: number = 0,
		pos3: number = 0,
		pos4: number = 0;

	//move the DIV from anywhere inside the DIV:
	element.addEventListener('mousedown', dragMouseDown);
	element.addEventListener('touchstart', dragMouseDown);

	function dragMouseDown(event: MouseEvent | TouchEvent) {
		// This causes inputs to not register
		// event.preventDefault();

		// get the mouse cursor position at startup:
		pos3 = event instanceof MouseEvent ? event.clientX : event.touches[0].clientX;
		pos4 = event instanceof MouseEvent ? event.clientY : event.touches[0].clientY;

		document.addEventListener('mouseup', closeDragElement, { passive: false });
		document.addEventListener('touchend', closeDragElement, { passive: false });

		// call a function whenever the cursor moves:
		document.addEventListener('mousemove', elementDrag, { passive: false });
		document.addEventListener('touchmove', elementDrag, { passive: false });
	}

	function elementDrag(event: MouseEvent | TouchEvent) {
		event.preventDefault();
		// calculate the new cursor position:
		pos1 = pos3 - (event instanceof MouseEvent ? event.clientX : event.touches[0].clientX);
		pos2 = pos4 - (event instanceof MouseEvent ? event.clientY : event.touches[0].clientY);
		pos3 = event instanceof MouseEvent ? event.clientX : event.touches[0].clientX;
		pos4 = event instanceof MouseEvent ? event.clientY : event.touches[0].clientY;

		// set the element's new position:
		element.style.top = element.offsetTop - pos2 + 'px';
		element.style.left = element.offsetLeft - pos1 + 'px';
	}

	function closeDragElement() {
		// stop moving when mouse button is released:
		document.removeEventListener('mouseup', closeDragElement);
		document.removeEventListener('touchend', closeDragElement);

		document.removeEventListener('mousemove', elementDrag);
		document.removeEventListener('touchmove', elementDrag);
	}
}
