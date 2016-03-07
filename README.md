# Angular Bootstrap Input Blocker

Angular Bootstrap Input Blocker is a directive for bootstrap, which allows blocking input with user provided template.
It is mostly useful for typeahead inputs, where modelValue contains more information than just simple string.

## Demo
Demo can be viewed [here](http://iisg.github.io/input-blocker/).

## Installation

Just require the package using bower:

```
bower install iisg/input-blocker --save
```

## Usage

*1st step*: Require the `fslab.inputblocker` in your main module.

    angular.module('myApp', [..., 'fslab.inputblocker'])
    
*2nd step*: Add `fslab-input-blocker` directive to existing input
(example with [ui-bootstrap typeahead](http://angular-ui.github.io/bootstrap/#/typeahead)).
No other attributes are needed.

    <input type="text"
           ng-model="selected"
           class="form-control"
           uib-typeahead="browser as browser.name for browser in browsers"
           typeahead-editable="false"
           fslab-input-blocker>
           
Custom template can be used by assigning value to `fslab-input-blocker`.

    <script type="text/ng-template"
            id="addressTemplate">
        <a target="_blank" ng-href="{{value.address}}">
            {{value.name}}
        </a>
    </script>
    <input type="text"
           ng-model="selected"
           class="form-control"
           uib-typeahead="browser as browser.name for browser in browsers"
           typeahead-editable="false"
           fslab-input-blocker='addressTemplate'>