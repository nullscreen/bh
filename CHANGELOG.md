# Changelog

All notable changes to this project will be documented in this file.

For more information about changelogs, check
[Keep a Changelog](http://keepachangelog.com) and
[Vandamme](http://tech-angels.github.io/vandamme).

## 1.3.0 - unreleased

* [ENHANCEMENT] Add `:help` option to display a help block after most form fields
* [FEATURE] Extend `button_to` to be wrapped in <li> when inside a `nav`, just like `link_to`
* [ENHANCEMENT] Bump Bootstrap version to 3.3.2
* [ENHANCEMENT] Bump Font Awesome version to 4.3.0

## 1.2.0 - 2014-11-13

* [FEATURE] Add support for Middleman and Padrino for all helpers except `form_for`
* [FEATURE] Extend `button_to` to accept the same :content, :size and :layout options as `button`
* [DEPRECATION] Deprecate `glyphicon` in favor of `icon` (`glyphicon` will still work until version 2.0.0)
* [BUGFIX] Don’t override `button_to` unless `:context`, `:size` or `:layout` is passed
* [ENHANCEMENT] Allow `alert_box` to pass extra parameters to the alert box <div>
* [ENHANCEMENT] Allow `button_to` to pass extra parameters to the button element
* [ENHANCEMENT] Allow `dropdown` to display a full-width button when called with `{layout: :block, groupable: false}`
* [ENHANCEMENT] Allow `dropdown` to pass `:id` parameter to the dropdown <ul>
* [ENHANCEMENT] Allow `modal` to pass the `:id` parameter to the wrapping <div>
* [ENHANCEMENT] Allow `modal` to pass `{button: :class}` parameter to the toggle <button>
* [ENHANCEMENT] Allow `panel` to pass extra parameters to the wrapping <div>
* [ENHANCEMENT] Allow `progress_bar` to pass extra parameters to the wrapping container
* [ENHANCEMENT] Allow `progress_bar` to pass extra parameters to each bar
* [ENHANCEMENT] Don’t render anything when `vertical` and `horizontal` are not wrapped in a `navbar`
* [ENHANCEMENT] Wrap plain content passed to `modal` inside the modal body
* [ENHANCEMENT] Wrap plain content passed to `panel` inside the panel body

## 1.1.1 - 2014-09-20

* [ENHANCEMENT] Bump Bootstrap version to 3.3.0

## 1.1.0 - 2014-09-20

* [FEATURE] Add `icon` helper
* [FEATURE] Add `font_awesome_css` helper
* [FEATURE] Add `dropdown` helper
* [FEATURE] Add `progress_bar` helper
* [ENHANCEMENT] Add `:fieldset` option to decide whether `fields_for` should wrap fields in a <fieldset> tag
* [FEATURE] Add `button` helper

## 1.0.1 - 2014-09-14

* [BUGFIX] Remove `form-control` class from `file_field` (#20)
* [BUGFIX] Allow `record_object` to be passed to `fields_for` (#22)

## 1.0.0 - 2014-09-09

* No changes

## 0.0.8 - 2014-08-25

* [FEATURE] Add `button_to` helper
* [FEATURE] Add `navbar` helper

## 0.0.7 - 2014-08-25

* [FEATURE] Add `nav` helper

## 0.0.6 - 2014-08-22

* [FEATURE] Add `:prefix`, `:suffix` options to form field helpers

## 0.0.5 - 2014-08-22

* [FEATURE] Add `form_for` and form helpers for every type of field

## 0.0.4 - 2014-08-17

* [FEATURE] Add `modal`
* [FEATURE] Add `panel_row`
* [FEATURE] Add `panel`
* [FEATURE] Add `glyphicon`

## 0.0.3 - 2014-08-15

* [FEATURE] Add `bootstrap_css`, `bootstrap_theme_css` and `bootstrap_js`

## 0.0.2 - 2014-08-15

* [FEATURE] Add `alert_box` helper
