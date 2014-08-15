Bh - Bootstrap Helpers
======================

Bh provides a set of helpers that streamlines the use of
[Bootstrap components](http://getbootstrap.com/components) in Rails views.

The **full documentation** is available at [rubydoc.info](http://rubydoc.info/github/Fullscreen/bh/master/frames).

[![Build Status](http://img.shields.io/travis/Fullscreen/bh/master.svg)](https://travis-ci.org/Fullscreen/bh)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/bh/master.svg)](https://coveralls.io/r/Fullscreen/bh)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/bh.svg)](https://gemnasium.com/Fullscreen/bh)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/bh.svg)](https://codeclimate.com/github/Fullscreen/bh)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://rubydoc.info/github/Fullscreen/bh/master/frames)
[![Gem Version](http://img.shields.io/gem/v/bh.svg)](http://rubygems.org/gems/bh)

Bootstrap is a great framework, but requires to write many lines of HTML code
even for simple components.
For instance, you need to write the following HTML to show a _dismissible alert_:

```html
<div class="alert alert-info alert-dismissible" role="alert">
  <button type="button" class="close" data-dismiss="alert">
    <span aria-hidden="true">&times;</span>
    <span class="sr-only">Close</span>
  </button>
  You accepted the Terms of service.
</div>
```

Writing this for every _dismissible alert_ in a web site is cumbersome,
repetitive, and prone to errors.

Bh offers a solution to this problem by means of a set of helper methods.
The example above can be rewritten with just one line of code:

```erb
<%= alert_box 'You accepted the Terms of service.', dismissible: true %>
```

`alert_box` is only of the helpers provided by Bh and described below.
You can use only the ones you need and even mix-and-match the "standard way"
of writing Bootstrap components (many HTML lines) with the "Bh way".

How to install
==============

Bh is meant to be included in Rails apps by adding this line to the Gemfile:

    gem 'bh', '~> 0.0.2'

Since the gem follows [Semantic Versioning](http://semver.org),
indicating the full version in your Gemfile (~> *major*.*minor*.*patch*)
guarantees that your project won’t occur in any error when you `bundle update`
and a new version of Bh is released.

Adding 'bh' to your Gemfile is all you need!
From now on, you will be able to use any of the following Bh helpers in your Rails views.

The `alert_box` helper
======================

To include [Boostrap alert boxes](http://getbootstrap.com/components/#alerts)
in your Rails views, you can use the [alert_box](http://rubydoc.info/github/Fullscreen/bh/master/Bh/AlertHelper) helper.
Here are some examples.

Basic alerts
------------

```erb
<%= alert_box 'You accepted the Terms of service.' %>
```

will generate the HTML to render an "info" alert:

```html
<div class="alert alert-info" role="alert">You accepted the Terms of service.</div>
```

![alert-basic](https://cloud.githubusercontent.com/assets/7408595/3936904/7c1c419c-24a7-11e4-9910-6452ab334c09.png)

Dismissible alerts
------------------

```erb
<%= alert_box 'You accepted the Terms of service.', dismissible: true %>
```

will generate the HTML to render an alert with an '×' to close it:

```html
<div class="alert alert-info" role="alert">
  <button class="close" data-dismiss="alert" type="button">
    <span aria-hidden="true">×</span><span class="sr-only">Close</span>
  </button>
  You accepted the Terms of service.
</div>
```

![alert-dismissible](https://cloud.githubusercontent.com/assets/7408595/3936901/7c107b00-24a7-11e4-8265-2752a630357a.png)

Contextual alerts
-----------------

```erb
<%= alert_box 'You accepted the Terms of service.', context: :success %>
```

will generate the HTML to render a "success" alert (green background):

```html
<div class="alert alert-success" role="alert">You accepted the Terms of service.</div>
```

Available contexts are `:success`, `:info` (default), `:warning`, `:danger`.

![alert-success](https://cloud.githubusercontent.com/assets/7408595/3936902/7c182a44-24a7-11e4-9f8b-7c381662128b.png)

Priority alerts
---------------

Since a common use of alert boxes in Rails applications is to display
[flash messages](http://api.rubyonrails.org/classes/ActionDispatch/Flash/FlashHash.html),
the `alert_box` helper accepts the priority of the flash message as an option.

```erb
<%= alert_box 'You accepted the Terms of service.', priority: :notice %>
```

will generate the HTML to render a dismissible "success" alert (green background):

```html
<div class="alert alert-success" role="alert">
  <button class="close" data-dismiss="alert" type="button">
    <span aria-hidden="true">×</span><span class="sr-only">Close</span>
  </button>
  You accepted the Terms of service.
</div>
```

Available priorities are `:alert`, `:notice`.

![alert-success-dismissible](https://cloud.githubusercontent.com/assets/7408595/3936900/7c0bdbcc-24a7-11e4-9b49-93468b7dc738.png)

Complex alerts
--------------

```erb
<%= alert_box context: :success, dismissible: true do %>
  <strong>Thanks!</strong> You accepted the <%= link_to 'Terms of service', '/terms' %>.
<% end %>
```

will generate the HTML to render a dismissible "success" alert that includes
highlighted text and appropriately styled links:

```html
<div class="alert alert-success" role="alert">
  <button class="close" data-dismiss="alert" type="button">
    <span aria-hidden="true">×</span><span class="sr-only">Close</span>
  </button>
  <strong>Thanks!</strong> You accepted the <a href="/terms" class="alert-link">Terms of service</a>.
</div>
```

![alert-complex](https://cloud.githubusercontent.com/assets/7408595/3936903/7c1b70f0-24a7-11e4-95ee-11f6920ddd4d.png)


How to release new versions
===========================

If you are a manager of this project, remember to upgrade the [Bh gem](http://rubygems.org/gems/bh)
whenever a new feature is added or a bug gets fixed.

Make sure all the tests are passing on [Travis CI](https://travis-ci.org/Fullscreen/bh),
document the changes in CHANGELOG.md and README.md, bump the version, then run

    rake release

Remember that the bh gem follows [Semantic Versioning](http://semver.org).
Any new release that is fully backward-compatible should bump the *patch* version (0.0.x).
Any new version that breaks compatibility should bump the *minor* version (0.x.0)

How to contribute
=================

Bh needs your support!

If you find that a method is missing, fork the project, add the missing code,
write the appropriate tests, then submit a pull request, and it will gladly
be merged! If you need an inspiration, look at the
[TODO](https://github.com/Fullscreen/bh/blob/master/TODO.md).

To run the tests, simply type `rspec` on the command line.

Don’t hesitate to send code comments, issues or pull requests through GitHub
and to spread the love. Thanks! :)
