exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js"

      // To use a separate vendor.js bundle, specify two files path
      // http://brunch.io/docs/config#-files-
      // joinTo: {
      //  "js/app.js": /^(js)/,
      //  "js/vendor.js": /^(vendor)|(deps)/
      // }
      //
      // To change the order of concatenation of files, explicitly mention here
      // order: {
      //   before: [
      //     "vendor/js/jquery-2.1.1.js",
      //     "vendor/js/bootstrap.min.js"
      //   ]
      // }
    },
    stylesheets: {
      joinTo: "css/app.css"
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      presets: ['es2015', 'react', 'stage-2', 'stage-0'],
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    },
    sass: {
      options: {
        includePaths: ['node_modules'],
      },
    },
    postcss: {
      processors: [
        require('autoprefixer')(['last 4 versions'])
      ]
    },
    copycat:{
      "fonts" : ["node_modules/font-awesome/fonts"],
      verbose : true, //shows each file that is copied to the destination directory
      onlyChanged: true //only copy a file if it's modified time has changed (only effective when using brunch watch)
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true,

    // Whitelist the npm deps to be pulled in as front-end assets.
    // All other deps in package.json will be excluded from the bundle.
    whitelist: [
      'bourbon',
      'bourbon-neat',
      'classnames',
      'es6-promise',
      'history',
      'invariant',
      'isomorphic-fetch',
      'moment',
      'phoenix',
      'phoenix_html',
      'react',
      'react-addons-css-transition-group',
      'react-dom',
      'react-gravatar',
      'react-page-click',
      'react-redux',
      'react-router',
      'react-router-redux',
      'redux',
      'redux-logger',
      'redux-thunk',
      'react-favicon',
    ]
  }
};
