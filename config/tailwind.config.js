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
    colors: {
      'willow': "#87A96B",
      'meadow': "#355E3B",
      'frost-green': "#67E6A8",
    },
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
