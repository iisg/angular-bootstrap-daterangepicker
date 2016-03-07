angular.module('fslab.daterangepicker').directive 'fslabDateRangePickerButton', (fslabDateRangePickerDirectiveDef) ->
  def = fslabDateRangePickerDirectiveDef()
  originalLink = def.link
  def.scope.ngModel = '='
  angular.extend def,
    template: '<span class="glyphicon glyphicon-calendar"></span> {{ ngModel | fslabDateRange }}'
    link: ($scope, $element, $attrs, $ngModelCtrl) ->
      originalLink($scope, $element, $attrs, $ngModelCtrl)
      $element.addClass('form-control')
      $element.attr('type', 'button')
