angular.module('fslab.daterangepicker').provider 'dateRangePickerConfig', ->
  new class
    constructor: ->
      @config =
        locale:
          format: 'YYYY-MM-DD'
          fromLabel: 'From'
          toLabel: 'To'
          applyLabel: 'OK'
          cancelLabel: 'Clear'
          customRangeLabel: 'Other'
          emptyFilterLabel: 'choose date range'
        ranges:
          'Incoming week': [moment(), moment().add(7, 'days')]
          'Tomorrow': [moment().add(1, 'days'), moment().add(1, 'days')]
          'Today': [moment(), moment()]
          'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')]
          'Past week': [moment().subtract(7, 'days'), moment()]
          'Past 30 days': [moment().subtract(30, 'days'), moment()]

    $get: =>
      @config



