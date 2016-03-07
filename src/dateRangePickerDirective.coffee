angular.module('fslab.daterangepicker').factory 'fslabDateRangePickerDirectiveDef', ($timeout, dateRangePickerConfig) ->
  ->
    require: 'ngModel'
    scope:
      minDate: '='
      maxDate: '='
    link: ($scope, element, attrs, modelController) ->
      minDate = if $scope.minDate == 'today' then moment().startOf('day') else $scope.minDate
      maxDate = if $scope.maxDate == 'today' then moment().endOf('day') else $scope.maxDate

      config = angular.copy(dateRangePickerConfig)

      # calculate which ranges to display based on min and maxDate;
      # range will be displayed only if it fits the min-max period fully
      # this varies from the deafult daterangepicker behavior (it displays the range if it intersects with min-max)
      rangeIsBetweenMinAndMax = (range) ->
        (!minDate or range[0].isAfter(minDate)) and (!maxDate or range[1].isBefore(maxDate))
      displayableRanges = {}
      displayableRanges[label] = range for label, range of config.ranges when rangeIsBetweenMinAndMax(range)

      config.ranges = displayableRanges
      config.maxDate = maxDate
      config.minDate = minDate

      element.daterangepicker(config)
      dateRangePicker = element.data('daterangepicker')

      modelController.$render = ->
        newValue = modelController.$modelValue
        if newValue?.startDate
          dateRangePicker.setStartDate(moment(newValue.startDate))
        if newValue?.endDate
          dateRangePicker.setEndDate(moment(newValue.endDate))

      $timeout ->
        element.on 'apply.daterangepicker', ->
          modelController.$setViewValue
            startDate: moment(dateRangePicker.startDate).toDate()
            endDate: moment(dateRangePicker.endDate).toDate()

        element.on 'cancel.daterangepicker', ->
          modelController.$setViewValue(undefined)


