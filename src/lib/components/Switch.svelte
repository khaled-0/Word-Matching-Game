<script>
	export let checked = false;
</script>

<label class="switch">
	<input class="opacity-0 w-0 h-0" type="checkbox" bind:checked />
	<span class="slider" />
</label>

<style lang="postcss">
	.switch {
		@apply relative inline-block;
		@apply large:h-8 large:w-14 h-6 w-11;
	}

	.slider {
		@apply absolute cursor-pointer rounded-3xl;
		@apply top-0 left-0 right-0 bottom-0;
		@apply global-container-bg;
	}

	.slider:before {
		@apply absolute content-[''];
		@apply left-0 top-[10%] bottom-[10%];
		@apply h-5 w-5 large:h-6 large:w-6 rounded-full;
		@apply bg-rich_black-600 dark:bg-platinum-600;
		@apply transition-[left,right];
	}

	input:checked + .slider {
		@apply bg-glaucous-600;
	}

	input:checked + .slider:before {
		@apply right-0 left-[55%];
	}
</style>
