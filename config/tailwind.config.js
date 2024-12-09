const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  darkMode: 'class', 
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './node_modules/flowbite/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Google Sans', ...defaultTheme.fontFamily.sans],
        verdana: ['Verdana', 'sans-serif'],
        gillsans: ['"Gill Sans"', 'sans-serif']
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require('flowbite/plugin')
  ]
}
