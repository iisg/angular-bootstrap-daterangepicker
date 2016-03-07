angular.module('fslab.daterangepicker').filter 'fslabDateRange', (dateFilter, dateRangePickerConfig) ->

  formatDate = (date) ->
    moment(date).format(dateRangePickerConfig.locale?.format or 'YYYY-MM-DD')

  (dateRange, labelIfEmpty = 'choose date range') ->
    if dateRange?.startDate
      result = formatDate(dateRange.startDate)
      if moment(dateRange.startDate).startOf('day').isBefore(moment(dateRange.endDate).startOf('day'))
        result += ' - ' + formatDate(dateRange.endDate)
      result
    else
      labelIfEmpty
