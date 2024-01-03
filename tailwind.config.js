/** @type {import('tailwindcss').Config} */
export default {
	content: ['./src/**/*.{html,js,svelte,ts}'],
	theme: {
		extend: {
			screens: {
				small: '480px',
				medium: '640px',
				large: '1024px'
			},
			colors: {
				rich_black: {
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
				powder_blue: {
					DEFAULT: '#a1c6ea',
					100: '#0f2740',
					200: '#1d4f80',
					300: '#2c76c0',
					400: '#5f9ddb',
					500: '#a1c6ea',
					600: '#b3d0ee',
					700: '#c6dcf2',
					800: '#d9e8f6',
					900: '#ecf3fb'
				},
				columbia_blue: {
					DEFAULT: '#bbd1ea',
					100: '#142941',
					200: '#285282',
					300: '#3c7bc2',
					400: '#7ca6d7',
					500: '#bbd1ea',
					600: '#cadbef',
					700: '#d7e4f3',
					800: '#e4edf7',
					900: '#f2f6fb'
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
	plugins: []
};
