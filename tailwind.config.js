/** @type {import('tailwindcss').Config} */
export default {
	content: [
		'./src/**/*.{html,js,svelte,ts}',
		'./node_modules/flowbite-svelte/**/*.{html,js,svelte,ts}'
	],
	darkMode: 'media',
	theme: {
		extend: {
			screens: {
				small: '480px',
				medium: '640px',
				large: '1024px'
			},
			colors: {
				primary: {
					50: '#eff8ff',
					100: '#dff0ff',
					200: '#b8e3ff',
					300: '#78cdff',
					400: '#37b6ff',
					500: '#069af1',
					600: '#007ace',
					700: '#0061a7',
					800: '#02528a',
					900: '#084572',
					950: '#062b4b'
				},
				glaucous: {
					DEFAULT: '#507dbc',
					100: '#0f1927',
					200: '#1e324e',
					300: '#2d4b76',
					400: '#3b649d',
					500: '#507dbc',
					600: '#7498ca',
					700: '#97b2d7',
					800: '#b9cbe5',
					900: '#dce5f2'
				},
				platinum: {
					DEFAULT: '#dae3e5',
					100: '#253235',
					200: '#4b6369',
					300: '#72949b',
					400: '#a7bcc0',
					500: '#dae3e5',
					600: '#e2e9eb',
					700: '#eaeff0',
					800: '#f1f4f5',
					900: '#f8fafa'
				}
			}
		}
	},
	plugins: [
		require('flowbite/plugin'),
		({ addComponents }) => {
			addComponents({
				'.global-field': {
					'@apply bg-slate-100 dark:bg-gray-700': {},
					'@apply mb-1': {}
				},
				'.global-field:first-child': {
					'border-top-left-radius': '0.75rem',
					'border-top-right-radius': '0.75rem'
				},
				'.global-field:last-child ': {
					'border-bottom-left-radius': ' 0.75rem',
					'border-bottom-right-radius': '0.75rem'
				}
			});
		}
	]
};
