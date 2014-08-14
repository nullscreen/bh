Bh - Bootstrap Helpers
======================

Bh lets you write Boostrap-style HTML pages without
the burden of having to memorize *every* class and attribute specified in the
[Bootstrap documentation](http://getbootstrap.com).

<!-- badges and docs here -->

A simple example of the convenience of Bh is the ability to insert a
[dismissible alert](http://getbootstrap.com/components/#alerts-dismissible)
with a single line of code:

```erb
<%= alert 'This alert needs your attention.', dismissible: true %>
```

A more structured example is the ability to insert a button that toggles a
[modal](http://getbootstrap.com/javascript/#modals-examples) asking a user
to confirm an action:

```erb
<%= modal 'Delete account', title: 'Confirm your action' do %>
  You are about to delete your account. Would you like to proceed?
  <%= footer do %>
    <button class="btn btn-danger">Yes, delete my account</button>
  <% end %>
<% end %>
```
<!-- The **full documentation** is available at [rubydoc.info]. -->

<!-- How to install -->

Alerts
======

Use the `alert` helper to insert any type of
[alert box](http://getbootstrap.com/components/#alerts) provided by Bootstrap.

Basic alerts
------------

```erb
<%= alert 'This alert needs your attention.' %>
```

will generates the HTML to render an "info" alert:

```html
<div class="alert alert-info" role="alert">This alert needs your attention.</div>
```

Dismissible alerts
------------------

```erb
<%= alert 'This alert needs your attention.', dismissible: true %>
```

will generates the HTML to render an alert with an '×' to close it:

```html
<div class="alert alert-info alert-dismissible" role="alert">
  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
  This alert needs your attention.
</div>
```

Contextual alerts
-----------------

```erb
<%= alert 'This important alert needs your attention.', context: :danger %>
```

will generates the HTML to render a "danger" alert (red background):

```html
<div class="alert alert-danger" role="alert">This important alert needs your attention.</div>
```

Available contexts are `:success`, `:info` (default), `:warning`, `:danger`.

<!-- Might document :priority only in the docs -->

Complex alerts
--------------

```erb
<%= alert context: :success, dismissible: true do %>
  <strong>Thanks!</strong> You accepted the <%= link_to '/terms', 'Terms of service' %>.
<% end %>
```

will generates the HTML to render a dismissible "success" alert that includes
highlighted text and links:

```html
<div class="alert alert-success alert-dismissible" role="alert">
  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
  <strong>Thanks!</strong> You accepted the <a href="/terms" class="alert-link">Terms of service</a>.
</div>
```

Modals
======

Use the `modal` helper to insert a button that will toggle any type of
[modal](http://getbootstrap.com/javascript/#modals) provided by Bootstrap.

Basic modals
------------

```erb
<%= modal 'Click to toggle a modal', 'I am the content of the modal' %>
```

will generates the HTML to render a button that, when clicked, will toggle
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

will generates the HTML to render a small "danger" (red) button that, when
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

