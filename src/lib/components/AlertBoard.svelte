<script lang="ts">
	export let message: string;
</script>

<div class="alert-container">
	<div class="alert-area global-container-bg">{message}</div>
</div>

<style lang="postcss">
	.alert-container {
		@apply fixed w-fit;
		@apply left-0 right-0;
		transform: translateX(calc(50svw - 50%));
		animation: run 2s infinite;
	}

	.alert-area {
		@apply h-full p-1 large:p-2;
		/* @apply flex flex-col justify-between; */
		@apply rounded-2xl;
		/* @apply border-gray-300 dark:border-gray-700; */
	}

	@keyframes run {
		from {
			transform: translateX(calc(50svw - 50%)) translateY(0px);
			opacity: 0.5;
		}
		50% {
			transform: translateX(calc(50svw - 50%)) translateY(1.5rem);
			opacity: 1;
		}
		to {
			transform: translateX(calc(50svw - 50%)) translateY(0px);
			opacity: 0;
		}
	}
</style>
