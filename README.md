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

```rhtml
<%= alert_box 'You accepted the Terms of service.', dismissible: true %>
```

`alert_box` is only of the helpers provided by Bh and described below.
You can use only the ones you need and even mix-and-match the "standard way"
of writing Bootstrap components (many HTML lines) with the "Bh way".

How to install
==============

Bh is meant to be included in Rails apps by adding this line to the Gemfile:

    gem 'bh', '~> 0.0.4'

Since the gem follows [Semantic Versioning](http://semver.org),
indicating the full version in your Gemfile (~> *major*.*minor*.*patch*)
guarantees that your project won’t occur in any error when you `bundle update`
and a new version of Bh is released.

Adding `bh` to your Gemfile is all you need!
From now on, you will be able to use any of the following Bh helpers in your Rails views.

AlertHelper
===========

To include [Boostrap alert boxes](http://getbootstrap.com/components/#alerts)
in your Rails views, you can use the [alert_box](http://rubydoc.info/github/Fullscreen/bh/master/Bh/AlertHelper) helper.
Here are some examples.

Basic alerts
------------

```rhtml
<%= alert_box 'You accepted the Terms of service.' %>
```

will generate the HTML to render an *info* alert:

```html
<div class="alert alert-info" role="alert">You accepted the Terms of service.</div>
```

![alert-basic](https://cloud.githubusercontent.com/assets/7408595/3936904/7c1c419c-24a7-11e4-9910-6452ab334c09.png)

Dismissible alerts
------------------

```rhtml
<%= alert_box 'You accepted the Terms of service.', dismissible: true %>
```

will generate the HTML to render an alert with an `×` to close it:

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

```rhtml
<%= alert_box 'You accepted the Terms of service.', context: :success %>
```

will generate the HTML to render a *success* alert (green background):

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

```rhtml
<%= alert_box 'You accepted the Terms of service.', priority: :notice %>
```

will generate the HTML to render a dismissible *success* alert (green background):

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

```rhtml
<%= alert_box context: :success, dismissible: true do %>
  <strong>Thanks!</strong> You accepted the <%= link_to 'Terms of service', '/terms' %>.
<% end %>
```

will generate the HTML to render a dismissible *success* alert that includes
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

CdnHelper
=========

To load the CSS and JS files of Bootstrap from
[BootstrapCDN](http://getbootstrap.com/getting-started/#download), you can use
the [bootstrap_css](http://rubydoc.info/github/Fullscreen/bh/master/Bh/CdnHelper),
[bootstrap_theme_css](http://rubydoc.info/github/Fullscreen/bh/master/Bh/CdnHelper) and
[bootstrap_js](http://rubydoc.info/github/Fullscreen/bh/master/Bh/CdnHelper) helpers.
Here are some examples.

Load the latest Bootstrap assets
--------------------------------

```rhtml
<%= stylesheet_link_tag bootstrap_css, bootstrap_theme_css, :application %>
<%= javascript_include_tag bootstrap_js, :application %>
```

will generate the HTML to load the latest versions of Bootstrap CSS, Bootstrap
Theme CSS and Bootstrap JS from MaxCDN, before your application assets:

```html
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" media="screen" rel="stylesheet" type="text/css" />
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css" media="screen" rel="stylesheet" type="text/css" />
<link href="/assets/application.css" media="screen" rel="stylesheet" type="text/css" />

<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js" type="text/javascript"></script>
<script src="/assets/application.js" type="text/javascript"></script>
```

Load a specific version of a Bootstrap asset
--------------------------------------------

```rhtml
<%= stylesheet_link_tag bootstrap_css(version: '3.1.0', minified: false, scheme: :http) %>
```

will generate the HTML to load the non-minified 3.1.0 versions of Bootstrap CSS
over HTTP scheme:

```html
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.css" media="screen" rel="stylesheet" type="text/css" />
```

GlyphiconHelper
===============

To display [glyphicons](http://getbootstrap.com/components/#glyphicons),
you can use the
[glyphicon](http://rubydoc.info/github/Fullscreen/bh/master/Bh/GlyphiconHelper) helper.
Here are some examples.

Display the "zoom in" icon
--------------------------

```rhtml
<%= glyphicon :ok, title: 'Approved' %>
```

will generate the HTML to render an "ok" icon with the "Approved" title:

```html
<span class="glyphicon glyphicon-ok" title="Approved"></span>
```

![glyphicon](https://cloud.githubusercontent.com/assets/7408595/3941608/64219c82-2537-11e4-8e86-27d4a62b1c06.png)

Available glyphicons are listed in [Boostrap documentation](http://getbootstrap.com/components/#glyphicons).

PanelHelper
===========

To include [Boostrap panels](http://getbootstrap.com/components/#panels)
in your Rails views, you can use the
[panel](http://rubydoc.info/github/Fullscreen/bh/master/Bh/PanelHelper) helper.
Here are some examples.

Basic panel
-----------

```rhtml
<%= panel body: 'You accepted the Terms of service.' %>
```

will generate the HTML to render a basic panel:

```html
<div class="panel panel-default">
  <div class="panel-body">You accepted the Terms of service.</div>
</div>
```
![panel-basic](https://cloud.githubusercontent.com/assets/7408595/3941817/da52bd6c-2543-11e4-87ae-eb1c7ed9df68.png)

Panel with heading
------------------

```rhtml
<%= panel body: 'You accepted the Terms of service.', heading: 'Congratulations' %>
```

will generate the HTML to render a panel with a heading:

```html
<div class="panel panel-default">
  <div class="panel-heading">Congratulations</div>
  <div class="panel-body">You accepted the Terms of service.</div>
</div>
```

![panel-heading](https://cloud.githubusercontent.com/assets/7408595/3941820/da58db3e-2543-11e4-811f-f7da4ffce77d.png)

Panel with title
------------------

```rhtml
<%= panel body: 'You accepted the Terms of service.', title: 'Congratulations' %>
```

will generate the HTML to render a panel with a title:

```html
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">Congratulations</h3>
  </div>
  <div class="panel-body">You accepted the Terms of service.</div>
</div>
```

![panel-title](https://cloud.githubusercontent.com/assets/7408595/3941816/da52b894-2543-11e4-99b8-4b6ffd47c167.png)

Contextual panel
-----------------

```rhtml
<%= panel body: 'You accepted the Terms of service.', title: 'Congratulations', context: :success %>
```

will generate the HTML to render a *success* panel (green background):

```html
<div class="panel panel-success">
  <div class="panel-heading">
    <h3 class="panel-title">Congratulations</h3>
  </div>
  <div class="panel-body">You accepted the Terms of service.</div>
</div>
```

Available contexts are `:default` (default), `:primary`, `:success`, `:info`,
`:warning` and `:danger`.

![panel-context](https://cloud.githubusercontent.com/assets/7408595/3941818/da562ba0-2543-11e4-87ce-54e143538219.png)

Complex panels
--------------

```rhtml
<%= panel tag: :aside do %>
  <div class='panel-body'>You accepted the Terms of service. <%= glyphicon :ok %></div>
  <div class='panel-footer'><h4>Thanks</h4></div>
<% end %>
```

will generate the HTML to render an aside panel with HTML body and footer:

```html
<aside class="panel panel-default">
  <div class="panel-body">
    You accepted the Terms of service.
    <span class="glyphicon glyphicon-ok"></span>
  </div>
  <div class="panel-footer"><h4>Thanks</h4></div>
</aside>
```

![panel-complex](https://cloud.githubusercontent.com/assets/7408595/3941819/da569586-2543-11e4-8640-3f0a72077aca.png)


PanelRowHelper
==============

To include a row of [Boostrap panels](http://getbootstrap.com/components/#panels)
in your Rails views, you can use the
[panel_row](http://rubydoc.info/github/Fullscreen/bh/master/Bh/PanelRowHelper) helper.
Here are some examples.

Basic row of panels
-------------------

```rhtml
<%= panel_row column_class: 'col-sm-4' do %>
  <%= panel body: 'Panel #1' %>
  <%= panel body: 'Panel #2' %>
  <%= panel body: 'Panel #3' %>
<% end %>
```

will generate the HTML to render a row of three basic panels:

```html
<div class="row">
  <div class="col-sm-4">
    <div class="panel panel-default"><div class="panel-body">Panel #1</div></div>
  </div>
  <div class="col-sm-4">
    <div class="panel panel-default"><div class="panel-body">Panel #2</div></div>
  </div>
  <div class="col-sm-4">
    <div class="panel panel-default"><div class="panel-body">Panel #3</div></div>
  </div>
</div>
```

![panel-row-basic](https://cloud.githubusercontent.com/assets/7408595/3942060/48967f30-2552-11e4-8b9c-a647d1569d5c.png)

Complex row of panels
---------------------

```rhtml
<%= panel_row column_class: 'col-sm-4' do %>
  <%= panel title: 'User', context: :info do %>
    <div class='panel-body'><%= glyphicon :user %> John Smith</div>
  <% end %>
  <%= panel title: 'Phone' do %>
    <div class='panel-body'><%= glyphicon :earphone %> 323-555-5555</div>
  <% end %>
  <%= panel title: 'City' do %>
    <div class='panel-body'><%= glyphicon :record %> Los Angeles, CA</div>
  <% end %>
<% end %>
```

will generate the HTML to render a row of three panels with title and HTML body:

```html
<div class="row">
  <div class="col-sm-4"><div class="panel panel-info">
    <div class="panel-heading"><h3 class="panel-title">User</h3></div>
    <div class="panel-body"><span class="glyphicon glyphicon-user"></span> John Smith</div>
  </div></div>
  <div class="col-sm-4"><div class="panel panel-default">
    <div class="panel-heading"><h3 class="panel-title">Phone</h3></div>
    <div class="panel-body"><span class="glyphicon glyphicon-earphone"></span> 323-555-5555</div>
  </div></div>
  <div class="col-sm-4"><div class="panel panel-default">
    <div class="panel-heading"><h3 class="panel-title">City</h3></div>
    <div class="panel-body"><span class="glyphicon glyphicon-record"></span> Los Angeles, CA</div>
  </div></div>
</div>
```

![panel-row-complex](https://cloud.githubusercontent.com/assets/7408595/3942061/489d1bc4-2552-11e4-9b00-d724b7c2c908.png)

ModalHelper
===========

To include [Boostrap modals](http://getbootstrap.com/javascript/#modals)
in your Rails views, you can use the
[modal](http://rubydoc.info/github/Fullscreen/bh/master/Bh/ModalHelper) helper.
Here are some examples.

Basic modal
-----------

```rhtml
<%= modal title: 'Terms of service', body: 'Do what you want!' %>
```

will generate the HTML to render a button that toggles a model when clicked:

```html
<button class="btn btn-default" data-toggle="modal" data-target="#modal-8684506463">
  Terms of service
</button>
<div class="modal fade" id="modal-8684506463" tabindex="-1" role="dialog" aria-labelledby="label-modal-8684506463" aria-hidden="true" style="display: none;">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">
          <span aria-hidden="true">×</span><span class="sr-only">Close</span>
        </button>
        <h4 class="modal-title" id="label-modal-8684506463">Terms of service</h4>
      </div>
      <div class="modal-body">Do what you want!</div>
    </div>
  </div>
</div>
```

![modal-basic](https://cloud.githubusercontent.com/assets/7408595/3943921/b471d3c2-25d8-11e4-9b40-d8bab38ba572.png)

Complex modal
-------------

```rhtml
<%= modal title: 'Terms of service', size: :small, button: {caption: 'Continue', size: :large, context: :info} do %>
  Please accept the Terms of service.
  <div class="modal-footer"><button type="button" class="btn btn-primary">Accept</button></div>
<% end %>
```

will generate the HTML to render a large, *info* button (blue background) with
the caption "Continue" that toggles a small modal with a title and HTML content:

```html
<button class="btn btn-info btn-lg" data-toggle="modal" data-target="#modal-8022670096">
  Continue
</button>
<div class="modal fade in" id="modal-8022670096" tabindex="-1" role="dialog" aria-labelledby="label-modal-8022670096" aria-hidden="false" style="display: block;">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">
          <span aria-hidden="true">×</span><span class="sr-only">Close</span>
        </button>
        <h4 class="modal-title" id="label-modal-8022670096">Terms of service</h4>
      </div>
      Please accept the Terms of service.
      <div class="modal-footer"><button type="button" class="btn btn-primary">Accept</button></div>
    </div>
  </div>
</div>
```

![modal-complex](https://cloud.githubusercontent.com/assets/7408595/3943922/b47620a8-25d8-11e4-9e0c-803d8a104bff.png)

FormForHelper
=============

To include [Boostrap forms](http://getbootstrap.com/css/#forms)
in your Rails views, you can use the
[form_for](http://rubydoc.info/github/Fullscreen/bh/master/Bh/FormForHelper)
helper.

By default, Bh does not override the `form_for` method provided by [ActionView](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-form_for).
To apply Bootstrap classes and attributes, you **must** set the `:layout` option to

* `:basic`, in order to get a [Basic form](http://getbootstrap.com/css/#forms-example)
* `:horizontal`, in order to get a [Horizontal form](http://getbootstrap.com/css/#forms-horizontal)
* `:inline`, in order to get an [Inline form](http://getbootstrap.com/css/#forms-inline)

Basic form
-----------

```rhtml
<%= form_for user, layout: :basic do |f| %>
  <%= f.fieldset 'Basic Info' do %>
    <%= f.text_field :name %>
    <%= f.text_field :age %>
  <% end %>
  <%= f.submit %>
<% end %>
```


Horizontal form
---------------

```rhtml
<%= form_for user, layout: :horizontal do |f| %>
  <%= f.fields_for :address do |address_f| %>
    <%= address_f.text_field :street, label: 'Street/Road' %>
    <%= address_f.text_area :notes, cols: 2 %>
  <% end %>
  <%= f.submit 'Send', class: 'pull-right' %>
<% end %>
```

Inline form
-----------

```rhtml
<%= form_for user, layout: :inline do |f| %>
  <%= f.email_field :email %>
  <%= f.password_field :password %>
  <%= f.check_box :remember_me %>
  <%= f.submit 'Login', context: :success %>
<% end %>
```


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
