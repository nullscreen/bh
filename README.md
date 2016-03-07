Bh · Bootstrap Helpers
======================

A set of Ruby helpers that streamlines the use of
[Bootstrap 3 components](http://getbootstrap.com/components) in HTML views.

The **full documentation** is available at [rubydoc.info](http://www.rubydoc.info/github/Fullscreen/bh/master/Bh/Helpers).

[![Build Status](http://img.shields.io/travis/Fullscreen/bh/master.svg)](https://travis-ci.org/Fullscreen/bh)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/bh/master.svg)](https://coveralls.io/r/Fullscreen/bh)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/bh.svg)](https://gemnasium.com/Fullscreen/bh)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/bh.svg)](https://codeclimate.com/github/Fullscreen/bh)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/github/Fullscreen/bh/master/Bh/Helpers)
[![Gem Version](http://img.shields.io/gem/v/bh.svg)](http://rubygems.org/gems/bh)

Bootstrap 3 is a great framework, but requires many lines of HTML code
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

Writing this for every _dismissible alert_ is cumbersome,
repetitive, and prone to errors.

With Bh, you can achieve the same result with just one line of code:

```rhtml
<%= alert_box 'You accepted the Terms of service.', dismissible: true %>
```

`alert_box` is only one of the helpers provided by Bh.
The other ones are: `bootstrap_css`, `bootstrap_js`, `bootstrap_theme_css`,
`button_to`, `button`, `dropdown`, `font_awesome_css`, `form_for`,
`icon`, `modal`, `navbar`, `nav`, `panel_row`, `panel` and `progress_bar`.

How to install
==============

Bh is compatible with **Rails 3.2**, **Rails 4**, **Padrino** and **Middleman**.

To include the Bh gem in your project:

1. Add `gem 'bh', '~> 1.3'` to the `Gemfile` file of your Rails, Padrino or Middleman project.
2. *Only if you are using Middleman*: open `config.rb` and add `activate :bh`.
3. *Only if you are using Padrino*: open `app.rb` and add `register Bh`.

That’s all!
From now on, you will be able to use any Bh helper in your views.

A comprehensive guide to Bh helpers
===================================

All the helpers available in Bh are detailed on the [Bh homepage](http://fullscreen.github.io/bh):

[![Bh homepage](https://cloud.githubusercontent.com/assets/7408595/4195282/5e823a9c-37bc-11e4-865d-bbc04aab38ec.png)](http://fullscreen.github.io/bh)

Please proceed to [http://fullscreen.github.io/bh](http://fullscreen.github.io/bh) for more details and examples on how to use Bh.

How to try it in your browser
=============================

The `examples` folder includes three sample apps that you can rapidly run in
your browser and edit as you please, in order to visually appreciate the result
of Bh.

If you’d like to run the _test Rails app_:

1. Download the source code
1. `cd` into the `examples/rails` folder
1. Run `bundle install`
1. Run `bundle exec rails server`
1. Point your browser to [http://0.0.0.0:3000](http://0.0.0.0:3000)

If you prefer to see the helpers inside a _test Middleman app_:

1. Download the source code
1. `cd` into the `examples/middleman` folder
1. Run `bundle install`
1. Run `bundle exec middleman`
1. Point your browser to [http://0.0.0.0:4567](http://0.0.0.0:4567)

If you prefer to see the helpers inside a _test Padrino app_:

1. Download the source code
1. `cd` into the `examples/padrino` folder
1. Run `bundle install`
1. Run `bundle padrino start`
1. Point your browser to [http://0.0.0.0:3000](http://0.0.0.0:3000)


How to update
=============

Bh strictly follows [Semantic Versioning](http://semver.org).
By indicating the version number in the *'~> major.minor'* format  in your
Gemfile, you are guaranteed that that your project won’t break when you
`bundle update` to a new version.

Whenever a new version is released, the [CHANGELOG file](https://github.com/claudiob/bh/blob/master/CHANGELOG.md)
will include a description of what features have changed and how to upgrade
your code, if necessary.

The full [history of Bh versions](https://gemnasium.com/gems/bh/versions) is also available.

To stay updated with the latest releases, to receive code examples,
implementation details and announcements, please consider subscribing to the
[Bh mailing list](http://eepurl.com/2Hwfb):

[![Bh mailing list](https://cloud.githubusercontent.com/assets/7408595/4204475/b8f1d8fe-3837-11e4-8e2f-79b017f583e1.png)](http://eepurl.com/2Hwfb)

How to release new versions
===========================

If you are a manager of this project, remember to upgrade the [Bh gem](http://rubygems.org/gems/bh)
whenever a new feature is added or a bug gets fixed.

Make sure all the tests are passing on [Travis CI](https://travis-ci.org/Fullscreen/bh),
document the changes in CHANGELOG.md and README.md, bump the version, then run

    rake release

Remember that the bh gem follows [Semantic Versioning](http://semver.org).

Any new release that makes backward-compatible bug fixes should bump the *patch* version (1.1.x).

Any new release that adds backward-compatible features should bump the *minor* version (1.x.0).

Any new version that breaks compatibility should bump the *major* version (2.0.0)

How to contribute
=================

Bh needs your support!

If you find that a method is missing, fork the project, add the missing code,
write the appropriate tests, then submit a pull request, and it will gladly
be merged!

To run the tests, simply type `bundle exec rspec` on the command line.

Don’t hesitate to send code pull requests through GitHub
and to spread the love. And [don’t click here](http://bit.ly/move-to-la)! Thanks! :)
