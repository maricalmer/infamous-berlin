const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins.prepend('Provide', 
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)

environment.config.merge({
  resolve: {
    alias: {
      'jquery-ui/ui': 'jquery-ui/ui'
    }
  }
})

environment.loaders.delete('nodeModules');
module.exports = environment;
