gulp = require('gulp')
$ = require('gulp-load-plugins')()
del = require('del')

buildCoffee = ->
  gulp.src 'src/**/*.coffee'
  .pipe $.coffee({bare: true})
  .pipe $.angularFilesort()
  .pipe $.ngAnnotate()

gulp.task 'lint', ->
  gulp.src 'src/**/*.coffee'
  .pipe $.coffeelint('coffeelint.json')
  .pipe $.coffeelint.reporter()
  .pipe $.coffeelint.reporter('fail')

gulp.task 'scripts.normal', ->
  buildCoffee()
  .pipe $.concat('date-range-picker.js')
  .pipe gulp.dest('dist')

gulp.task 'scripts.min', ->
  buildCoffee()
  .pipe $.concat('date-range-picker.min.js')
  .pipe $.uglify()
  .pipe gulp.dest('dist')

gulp.task 'scripts', ['scripts.normal', 'scripts.min']

gulp.task 'clean', ->
  del ['dist/*', '!dist/bower_components']

gulp.task 'watch', ['scripts.normal'], ->
  gulp.watch 'src/**/*.coffee', ['scripts.normal']

gulp.task 'default', ['clean', 'lint', 'scripts']
