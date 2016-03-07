angular.module('fslab.daterangepicker').directive 'fslabDateRangePickerButton', ->
  require: 'ngModel'
  scope:
    ngModel: '='
    maxDate: '='
    minDate: '='
  template: """
    <button type="button"
      class="form-control fslab-date-range-picker-button"
      fslab-date-range-picker
      max-date="maxDate"
      min-date="minDate"
      ng-model="ngModel">
        {{ ngModel | fslabDateRange }}
    </button>
"""

