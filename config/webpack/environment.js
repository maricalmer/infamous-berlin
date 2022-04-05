const { environment } = require('@rails/webpacker')

// const webpack = require('webpack');
// // Preventing Babel from transpiling NodeModules packages
// environment.loaders.delete('nodeModules');
// module.exports = environment


const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)
environment.loaders.delete('nodeModules');
module.exports = environment
