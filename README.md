# Angular Bootstrap Date Range Picker

Angular Bootstrap Date Range Picker directive that uses the [bootstrap-daterangepicker](https://github.com/dangrossman/bootstrap-daterangepicker) beneath.

## Demo
[CLICK](http://iisg.github.io/angular-bootstrap-daterangepicker/)

## Installation

```
bower install iisg/angular-bootstrap-daterangepicker --save
```

## Usage

Require the `fslab.inputblocker` in your main module.

    angular.module('myApp', ['fslab.daterangepicker'])

And use it in your view

    <button fslab-date-range-picker
            ng-model="dateRange"
            class="btn btn-default">
            {{ dateRange | fslabDateRange }}
    </button>

Or for button that looks like an input:

    <span fslab-date-range-picker-button ng-model="dateRange"></span>

## Available directive attributes

* `max-date` should be given in the format specified in the locale configuration or `'today'` if the maximum allowed date should be the same as current date (only past dates)
* `min-date` should be given in the format specified in the locale configuration or `'today'` if the minimum allowed date should be the same as current date (only future dates)

## Configuration

You can set any option the [bootstrap-daterangepicker supports](http://www.daterangepicker.com/#options). You can see the default configuration below:

    angular.module("myApp").config (dateRangePickerConfigProvider) ->
      dateRangePickerConfigProvider.config.locale =
        format: 'YYYY-MM-DD'
        fromLabel: 'From'
        toLabel: 'To'
        applyLabel: 'OK'
        cancelLabel: 'Clear'
        customRangeLabel: 'Other'
        emptyFilterLabel: 'choose date range'
      dateRangePickerConfigProvider.config.ranges =
        'Incoming week': [moment(), moment().add(7, 'days')]
        'Tomorrow': [moment().add(1, 'days'), moment().add(1, 'days')]
        'Today': [moment(), moment()]
        'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')]
        'Past week': [moment().subtract(7, 'days'), moment()]
        'Past 30 days': [moment().subtract(30, 'days'), moment()]
