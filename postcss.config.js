const environment = ctx => ({
  plugins: [
    require("postcss-import"),
    require("postcss-flexbugs-fixes"),
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009"
      },
      stage: 3
    }),
    purgeCss(ctx)
  ]
});

const purgeCss = ({ file }) => {
  return require("@fullhuman/postcss-purgecss")({
    content: htmlFilePatterns(file.basename),
    defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || [],
  });
};

const htmlFilePatterns = filename => {
  switch (filename) {
    case "critical.scss":
      return [
        "./app/views/pages/index.html.erb",
        "./app/views/shared/_navbar.html.erb",
        "./app/views/layouts/application.html.erb"
      ];
    default:
      return [
        "./app/**/*.html.erb",
        "./config/initializers/simple_form_bootstrap.rb",
        "./app/helpers/**/*.rb",
        "./app/javascript/**/*.js"
      ];
  }
};

module.exports = ctx => environment(ctx);
