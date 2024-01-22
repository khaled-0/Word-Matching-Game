// https://svelte.dev/repl/a95db12c1b46433baac2817a0963dc93?version=4.2.9
export default function preventTabClose(_: HTMLElement, enabled: boolean = true) {
	setHandler(enabled);
	return {
		update: setHandler,
		destroy: () => setHandler(false)
	};
}

function setHandler(shouldWork: boolean) {
	if (shouldWork) {
		window.addEventListener('beforeunload', (e) => {
			e.preventDefault();
		});
	} else {
		window.removeEventListener('beforeunload', (e) => {
			e.preventDefault();
		});
	}
}
