angular.module('fslab.daterangepicker', []);

var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

angular.module('fslab.daterangepicker').provider('dateRangePickerConfig', function() {
  return new ((function() {
    function _Class() {
      this.$get = bind(this.$get, this);
      this.config = {
        locale: {
          format: 'YYYY-MM-DD',
          fromLabel: 'From',
          toLabel: 'To',
          applyLabel: 'OK',
          cancelLabel: 'Clear',
          customRangeLabel: 'Other'
        },
        ranges: {
          'Incoming week': [moment(), moment().add(7, 'days')],
          'Tomorrow': [moment().add(1, 'days'), moment().add(1, 'days')],
          'Today': [moment(), moment()],
          'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
          'Past week': [moment().subtract(7, 'days'), moment()],
          'Past 30 days': [moment().subtract(30, 'days'), moment()]
        }
      };
    }

    _Class.prototype.$get = function() {
      return this.config;
    };

    return _Class;

  })());
});

angular.module('fslab.daterangepicker').directive('fslabDateRangePicker', ["$timeout", "dateRangePickerConfig", function($timeout, dateRangePickerConfig) {
  return {
    require: 'ngModel',
    scope: {
      minDate: '=',
      maxDate: '='
    },
    link: function($scope, element, attrs, modelController) {
      var config, dateRangePicker, displayableRanges, label, maxDate, minDate, range, rangeIsBetweenMinAndMax, ref;
      minDate = $scope.minDate === 'today' ? moment().startOf('day') : $scope.minDate;
      maxDate = $scope.maxDate === 'today' ? moment().endOf('day') : $scope.maxDate;
      config = angular.copy(dateRangePickerConfig);
      rangeIsBetweenMinAndMax = function(range) {
        return (!minDate || range[0].isAfter(minDate)) && (!maxDate || range[1].isBefore(maxDate));
      };
      displayableRanges = {};
      ref = config.ranges;
      for (label in ref) {
        range = ref[label];
        if (rangeIsBetweenMinAndMax(range)) {
          displayableRanges[label] = range;
        }
      }
      config.ranges = displayableRanges;
      config.maxDate = maxDate;
      config.minDate = minDate;
      element.daterangepicker(config);
      dateRangePicker = element.data('daterangepicker');
      $scope.$watch((function() {
        return modelController.$modelValue;
      }), function(newValue) {
        if (newValue != null ? newValue.startDate : void 0) {
          dateRangePicker.setStartDate(moment(newValue.startDate));
        }
        if (newValue != null ? newValue.endDate : void 0) {
          return dateRangePicker.setEndDate(moment(newValue.endDate));
        }
      });
      return $timeout(function() {
        element.on('apply.daterangepicker', function() {
          return modelController.$setViewValue({
            startDate: moment(dateRangePicker.startDate).toDate(),
            endDate: moment(dateRangePicker.endDate).toDate()
          });
        });
        return element.on('cancel.daterangepicker', function() {
          return modelController.$setViewValue(void 0);
        });
      });
    }
  };
}]);

angular.module('fslab.daterangepicker').filter('fslabDateRange', ["dateFilter", "dateRangePickerConfig", function(dateFilter, dateRangePickerConfig) {
  var formatDate;
  formatDate = function(date) {
    var ref;
    return moment(date).format(((ref = dateRangePickerConfig.locale) != null ? ref.format : void 0) || 'YYYY-MM-DD');
  };
  return function(dateRange, labelIfEmpty) {
    var result;
    if (labelIfEmpty == null) {
      labelIfEmpty = 'choose date range';
    }
    if (dateRange != null ? dateRange.startDate : void 0) {
      result = formatDate(dateRange.startDate);
      if (moment(dateRange.startDate).startOf('day').isBefore(moment(dateRange.endDate).startOf('day'))) {
        result += ' - ' + formatDate(dateRange.endDate);
      }
      return result;
    } else {
      return labelIfEmpty;
    }
  };
}]);