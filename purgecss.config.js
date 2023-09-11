module.exports = {
  content: ['./app/**/*.html.erb', './app/helpers/**/*.rb'],
  css: ['./app/assets/stylesheets/critical_small.css', './app/assets/stylesheets/critical_medium.css', './app/assets/stylesheets/critical_large.css'],
  output: './app/assets/stylesheets',
  safelist: {
    standard: [
      'textarea',
      'input',
      'button',
      'select',
      'optgroup',
      'turbo-frame',
      'pre',
      'html',
      'body'
    ],
    deep: [/some-custom-class/]
  }
}
