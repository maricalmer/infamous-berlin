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
    purgeCss(ctx),
    require("cssnano")({
      preset: "default"
    })
  ]
});

const purgeCss = ({ file }) => {
  return require("@fullhuman/postcss-purgecss")({
    content: htmlFilePatterns(file.basename),
    defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || [],
    extractors: [
      {
        extractor: require("purgecss-from-html"),
        extensions: ["html"]
      }
    ]
  });
};

const htmlFilePatterns = filename => {
  switch (filename) {
    case "critical.scss":
      return [
        "./app/views/layouts/application.html.erb",
        "./app/views/pages/home.html.erb",
        "./app/views/shared/_navbar.html.erb",
        "./app/views/shared/_preloader.html.erb",
        "./app/views/shared/_tap_btn.html.erb",
        "./app/views/shared/_cursor.html.erb",
        "./app/views/shared/_navbar.html.erb",
        "./app/views/shared/_login_form.html.erb",
        './app/javascript/**/*.js'
      ];
    default:
      return [
        "./app/**/*.html.erb",
        "./app/javascript/**/*.js"
      ];
  }
};

module.exports = ctx => environment(ctx);
