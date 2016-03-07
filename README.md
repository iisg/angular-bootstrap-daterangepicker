# Angular Bootstrap Date Range Picker

Angular Bootstrap Date Range Picker directive that uses the [bootstrap-daterangepicker](https://github.com/dangrossman/bootstrap-daterangepicker) beneath.

## Demo
[CLICK](http://iisg.github.io/angular-bootstrap-daterangepicker/)

## Installation

Just require the package using bower:

```
bower install iisg/angular-bootstrap-daterangepicker --save
```

## Usage

Require the `fslab.inputblocker` in your main module.

    angular.module('myApp', [..., 'fslab.daterangepicker'])

And use it in your view

    <button fslab-date-range-picker
            ng-model="dateRange"
            class="btn btn-default">
            {{ dateRange | fslabDateRange }}
    </button>

TODO
