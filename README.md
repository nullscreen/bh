Bh · Bootstrap Helpers
======================

Bh provides a set of helpers that streamlines the use of
[Bootstrap 3 components](http://getbootstrap.com/components) in Ruby views.

The **full documentation** is available at [rubydoc.info](http://rubydoc.info/github/Fullscreen/bh/master/frames).

[![Build Status](http://img.shields.io/travis/Fullscreen/bh/master.svg)](https://travis-ci.org/Fullscreen/bh)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/bh/master.svg)](https://coveralls.io/r/Fullscreen/bh)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/bh.svg)](https://gemnasium.com/Fullscreen/bh)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/bh.svg)](https://codeclimate.com/github/Fullscreen/bh)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://rubydoc.info/github/Fullscreen/bh/master/frames)
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

With Bh, you can achieve the same thing with just one line of code:

```rhtml
<%= alert_box 'You accepted the Terms of service.', dismissible: true %>
```

`alert_box` is only one of the helpers provided by Bh.
You can use the helpers you need and even mix-and-match the "standard way"
of writing Bootstrap 3 components (many HTML lines) with the "Bh way".

A comprehensive guide to Bh helpers
===================================

All the helpers available in Bh are detailed on the [Bh homepage](http://fullscreen.github.io/bh):

[![Bh homepage](https://cloud.githubusercontent.com/assets/7408595/4195282/5e823a9c-37bc-11e4-865d-bbc04aab38ec.png)](http://fullscreen.github.io/bh)

Please proceed to [http://fullscreen.github.io/bh](http://fullscreen.github.io/bh) for more details and examples on how to use Bh.


How to install
==============

Bh is meant to be included in Rails apps by adding this line to the Gemfile:

    gem 'bh', '~> 1.0'

Since the gem follows [Semantic Versioning](http://semver.org), indicating the
version number in your Gemfile in the *'~> major.minor'* format guarantees
that your project won’t break when you `bundle update` to a new version.

Adding `bh` to your Gemfile is all you need!
From now on, you will be able to use any Bh helper in your ERB views.

How to update
=============

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

Any new release that makes backward-compatible bug fixes should bump the *patch* version (1.0.x).

Any new release that adds backward-compatible features should bump the *minor* version (1.x.0).

Any new version that breaks compatibility should bump the *major* version (2.0.0)

How to contribute
=================

Bh needs your support!

If you find that a method is missing, fork the project, add the missing code,
write the appropriate tests, then submit a pull request, and it will gladly
be merged!

To run the tests, simply type `rspec` on the command line.

Don’t hesitate to send code comments, issues or pull requests through GitHub
and to spread the love. Thanks! :)
