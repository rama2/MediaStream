"use strict"
__indexOf_ = [].indexOf or (item) ->
  i = 0
  l = @length

  while i < l
    return i  if i of this and this[i] is item
    i++
  -1

angular.module("rokumanv1.1App").directive "chosen", ["$timeout", ($timeout) ->
  CHOSEN_OPTION_WHITELIST = undefined
  NG_OPTIONS_REGEXP = undefined
  chosen = undefined
  isEmpty = undefined
  snakeCase = undefined
  NG_OPTIONS_REGEXP = /^\s*(.*?)(?:\s+as\s+(.*?))?(?:\s+group\s+by\s+(.*))?\s+for\s+(?:([\$\w][\$\w\d]*)|(?:\(\s*([\$\w][\$\w\d]*)\s*,\s*([\$\w][\$\w\d]*)\s*\)))\s+in\s+(.*)$/
  CHOSEN_OPTION_WHITELIST = ["noResultsText", "allowSingleDeselect", "disableSearchThreshold", "disableSearch", "enableSplitWordSearch", "inheritSelectClasses", "maxSelectedOptions", "placeholderTextMultiple", "placeholderTextSingle", "searchContains", "singleBackstrokeDelete", "displayDisabledOptions", "displaySelectedOptions", "width"]
  snakeCase = (input) ->
    input.replace /[A-Z]/g, ($1) ->
      "_" + ($1.toLowerCase())


  isEmpty = (value) ->
    key = undefined
    _i = undefined
    _len = undefined
    if angular.isArray(value)
      return value.length is 0
    else if angular.isObject(value)
      _i = 0
      _len = value.length

      while _i < _len
        key = value[_i]
        return false  if value.hasOwnProperty(key)
        _i++
    true

  chosen =
    restrict: "A"
    require: "?ngModel"
    terminal: true
    link: (scope, element, attr, ctrl) ->
      disableWithMessage = undefined
      match = undefined
      options = undefined
      origRender = undefined
      startLoading = undefined
      stopLoading = undefined
      valuesExpr = undefined
      viewWatch = undefined
      options = scope.$eval(attr.chosen) or {}
      angular.forEach attr, (value, key) ->
        options[snakeCase(key)] = scope.$eval(value)  if __indexOf_.call(CHOSEN_OPTION_WHITELIST, key) >= 0

      startLoading = ->
        element.addClass("loading").attr("disabled", true).trigger "chosen:updated"

      stopLoading = ->
        element.removeClass("loading").attr("disabled", false).trigger "chosen:updated"

      disableWithMessage = (message) ->
        element.empty().append("<option selected>" + message + "</option>").attr("disabled", true).trigger "chosen:updated"

      $timeout ->
        element.chosen options

      if ctrl
        origRender = ctrl.$render
        ctrl.$render = ->
          origRender()
          element.trigger "chosen:updated"

        if attr.multiple
          viewWatch = ->
            ctrl.$viewValue

          scope.$watch viewWatch, ctrl.$render, true
      if attr.ngOptions
        match = attr.ngOptions.match(NG_OPTIONS_REGEXP)
        valuesExpr = match[7]
        startLoading()  if angular.isUndefined(scope.$eval(valuesExpr))
        scope.$watch valuesExpr, (newVal, oldVal) ->
          if newVal isnt oldVal
            stopLoading()
            disableWithMessage options.no_results_text or "No values available"  if isEmpty(newVal)

]