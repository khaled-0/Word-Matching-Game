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
					DEFAULT: '#04080f',
					100: '#010203',
					200: '#020306',
					300: '#03050a',
					400: '#03070d',
					500: '#04080f',
					600: '#19325d',
					700: '#2d5bab',
					800: '#648ed6',
					900: '#b2c6ea'
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
		({ addComponents, theme }) => {
			addComponents({
				'.global-container-bg': {
					backgroundColor: theme('colors.platinum.600'),
					'@media (prefers-color-scheme: dark)': {
						backgroundColor: theme('colors.glaucous.100')
					}
				},
				'.global-subcontainer-bg': {
					backgroundColor: theme('colors.platinum.800'),
					'@media (prefers-color-scheme: dark)': {
						backgroundColor: theme('colors.glaucous.200')
					}
				},

				'.global-field': {
					'@apply global-subcontainer-bg': {},
					'@apply my-1': {}
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
