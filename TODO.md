
Modals
======

Use the `modal` helper to insert a button that will toggle any type of
[modal](http://getbootstrap.com/javascript/#modals) provided by Bootstrap.

Basic modals
------------

```erb
<%= modal 'Click to toggle a modal', 'I am the content of the modal' %>
```

will generate the HTML to render a button that, when clicked, will toggle
a modal with some simple text:

```html
<button class="btn btn-primary" data-toggle="modal" data-target="#myModal">
  Click to toggle a modal
</button>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        I am the content of the modal
      </div>
    </div>
  </div>
</div>
```

Complex modals
--------------

```erb
<%= modal 'Delete account', title: 'Confirm your action', dismissible: true, context: :danger, button_class: 'btn-sm', modal_class: 'modal-sm' do %>
  You are about to delete your account. Would you like to proceed?
  <%= footer do %>
    <button class="btn btn-danger">Yes, delete my account</button>
  <% end %>
<% end %>

will generate the HTML to render a small "danger" (red) button that, when
clicked, will toggle a small, dismissible modal with a title, some text, and a
footer with a call-to-action:

```html
<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">
  Delete account
</button>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="mySmallModalLabel">Confirm your action</h4>
      </div>
      <div class="modal-body">
        You are about to delete your account. Would you like to proceed?
      </div>
      <div class="modal-footer">
        <button class="btn btn-danger">Yes, delete my account</button>
      </div>
    </div>
  </div>
</div>
```

Panels
======

Use the `panel` helper to insert any type of
[panel](http://getbootstrap.com/components/#panels) provided by Bootstrap.

Basic panels
------------

```erb
<%= panel 'You have the right to remain silent...' %>
```

will generate the HTML to render a basic panel:

```html
<div class="panel panel-default">
  <div class="panel-body">
    You have the right to remain silent...
  </div>
</div>
```

Panels with title
-----------------

```erb
<%= panel 'You have the right to remain silent...', title: 'Your rights' %>
```

will generate the HTML to render a panel with a simple title header:

```html
<div class="panel panel-default">
  <div class="panel-heading">
    <h2 class="panel-title">Your rights</h2>
  </div>
  <div class="panel-body">
    You have the right to remain silent...
  </div>
</div>
```

Body and title can be passed as blocks if they are more than plain text:

```erb
<%= panel do %>
  <strong>Hey!</strong> You have the right to remain silent...
  <%= title tag: :h3, do %>
    <strong>Your rights</strong> (from our <%= link_to '/terms', 'Terms of service' %>)
  <% end %>
<% end %>
```

will generate

```html
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">
      <strong>Your rights</strong> (from our <a href="/terms">Terms of service</a>)
    </h2>
  </div>
  <div class="panel-body">
    <strong>Hey!</strong> You have the right to remain silent...
  </div>
</div>
```

Contextual panels
-----------------

```erb
<%= panel 'You have the right to remain silent...', title: 'Your rights', context: :warning %>
```

will generate the HTML to render a "warning" (orange border) panel:

```html
<div class="panel panel-warning">
  <div class="panel-heading">
    <h2 class="panel-title">
      Your rights
    </h2>
  </div>
  <div class="panel-body">
    You have the right to remain silent...
  </div>
</div>
```

Panels with footer
------------------

```erb
<%= panel do %>
  You have the right to remain silent...
  <%= footer do %>
    <button class="btn btn-primary">Accept</button>
  <% end %>
<% end %>
```

will generate the HTML to render a panel with a button in the footer:

```html
<div class="panel panel-default">
  <div class="panel-body">
    You have the right to remain silent...
  </div>
  <div class="panel-footer">
    <button class="btn btn-primary">Accept</button>
  </div>
</div>
```

<!--
 TODO
 Both panel and modal should accept a title to override the header, or a header,
 or none of them and then they should not have the header component at all.
 For the size, though, they are different.
-->

Navbar
======

Basic navbar
------------

```erb
<%= navbar do %>
  <%= nav do %>
    <%= link_to 'Posts', '/posts' %>
    <%= link_to 'Users', '/users' %>
  <% end %>
<% end %>
```

will generate the HTML to render an default navbar with two links:

```html
<nav class="navbar" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button class="navbar-toggle" data-target="#bs-example-navbar-collapse-1" data-toggle="collapse" type="button">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="/posts">Posts</a></li>
        <li><a href="/users">Users</a></li>
      </ul>
    </div>
  </div>
</nav>
```


Complex navbar
--------------

<%= navbar fixed: :top, inverted: true do %>
  <%= brand do %>
    <%= link_to image_tag('logo.png', alt: 'Company Name'), '/' %>
  <% end %>
  <%= nav do %>
    <%= link_to 'Posts', '/posts' %>
    <%= link_to 'Users', '/users' %>
  <% end %>
  <%= nav align: :right do %>
    <%= link_to 'Log in', '/login' %>
  <% end %>
<% end %>

<!-- NOTE: to align a form to the right, it's not necessary to put it inside
     a "nav align: :right", it's enough to have the form directly, but form_for
     should be smart enough to add the 'navbar-form' class for better alignment -->

<style>body {padding-top: 70px}</style>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button class="navbar-toggle" data-target="#bs-example-navbar-collapse-1" data-toggle="collapse" type="button">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a href="/" class="navbar-brand">
        <img alt="Company Name" src="/logo.png">
      </a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="/posts">Posts</a></li>
        <li><a href="/users">Users</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="/login">Log in</a></li>
      </ul>
    </div>
  </div>
</nav>

Forms
=====

<%= form_for %>
<%= button_to %>
<%= link_to %>

Buttons
=======

<!-- TODO: explain that button_to is smarter, same for form_for, link_to
     they add extra-classes based on the context -->

Viewport meta tag
=================

<%= viewport_meta_tag %>

generates

<meta name="viewport" content="width=device-width, initial-scale=1">
