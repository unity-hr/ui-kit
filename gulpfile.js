'use strict';
// Generated on 2014-04-11 using generator-gulp-webapp 0.0.6

var gulp = require('gulp');
var connect = require('connect');
var http = require('http');
var open = require('open');
var wiredep = require('wiredep').stream;

// Load plugins
var $ = require('gulp-load-plugins')();


// Styles
gulp.task('styles', function () {
  return gulp.src('app/styles/main.scss')
    .pipe($.rubySass({
      style: 'expanded'
    }))
    .pipe($.autoprefixer('last 1 version'))
    .pipe(gulp.dest('.tmp/styles'))
    .pipe($.size());
});

// Scripts
gulp.task('scripts', function () {
  return gulp.src('app/scripts/**/*.coffee')
    .pipe($.coffee())
    .pipe(gulp.dest('.tmp/scripts'))
    .pipe($.size());
});

// HTML
gulp.task('html', ['styles', 'scripts'], function () {
  var jsFilter = $.filter('**/*.js');
  var cssFilter = $.filter('**/*.css');

  return gulp.src('app/*.html')
    .pipe($.useref.assets())
    .pipe(jsFilter)
    .pipe($.uglify())
    .pipe(jsFilter.restore())
    .pipe(cssFilter)
    .pipe($.csso())
    .pipe(cssFilter.restore())
    .pipe($.useref.restore())
    .pipe($.useref())
    .pipe(gulp.dest('dist'))
    .pipe($.size());
});

// Images
gulp.task('images', function () {
  return gulp.src('app/images/**/*')
    .pipe($.cache($.imagemin({
      optimizationLevel: 3,
      progressive: true,
      interlaced: true
    })))
    .pipe(gulp.dest('dist/images'))
    .pipe($.size());
});

// Fonts
gulp.task('fonts', function () {
  return $.bowerFiles()
    .pipe($.filter([
      '**/*.eot',
      '**/*.svg',
      '**/*.ttf',
      '**/*.woff'
    ]))
    .pipe($.flatten())
    .pipe(gulp.dest('dist/fonts'))
    .pipe($.size());
});

// Clean
gulp.task('clean', function () {
  return gulp.src(['.tmp', 'dist/styles', 'dist/scripts', 'dist/images', 'dist/fonts'], { read: false }).pipe($.clean());
});

// Build
gulp.task('build', ['html', 'images', 'fonts']);

// Default task
gulp.task('default', ['clean'], function () {
  gulp.start('build');
});

// Connect
gulp.task('connect', function() {
  var app = connect()
    .use(require('connect-livereload')({ port: 35729 }))
    .use(connect.static('app'))
    .use(connect.static('.tmp'))
    .use(connect.directory('app'))

  http.createServer(app)
    .listen(9000)
    .on('listening', function() {
      console.log('Started connect web server on http://localhost:9000');
    });
});

// Open
gulp.task('serve', ['connect', 'styles', 'scripts'], function() {
  open('http://localhost:9000');
});

// Inject Bower components
gulp.task('wiredep', function () {
  gulp.src('app/styles/*.scss')
    .pipe(wiredep({
      directory: 'app/bower_components'
    }))
    .pipe(gulp.dest('app/styles'));

  gulp.src('app/*.html')
    .pipe(wiredep({
      directory: 'app/bower_components',
      exclude: ['app/bower_components/bootstrap-sass-official/vendor/assets/javascripts/bootstrap.js']
    }))
    .pipe(gulp.dest('app'));
});

// Watch
gulp.task('watch', ['connect', 'serve'], function () {
  var server = $.livereload();

  // Watch for changes in `app` and `.tmp` folder
  gulp.watch([
    'app/*.html',
    '.tmp/styles/**/*.css',
    '.tmp/scripts/**/*.js',
    'app/images/**/*'
  ]).on('change', function (file) {
    server.changed(file.path);
  });

  // Watch .scss files
  gulp.watch('app/styles/**/*.scss', ['styles']);

  // Watch .coffee files
  gulp.watch('app/scripts/**/*.coffee', ['scripts']);

  // Watch image files
  gulp.watch('app/images/**/*', ['images']);

  // Watch bower files
  gulp.watch('bower.json', ['wiredep']);
});
