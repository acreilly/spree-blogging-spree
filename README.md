SpreeInspirationSpree
==================

[![Build Status](https://travis-ci.org/stefansenk/spree-inspiration-spree.png?branch=master)](https://travis-ci.org/stefansenk/spree-inspiration-spree)

A basic inspiration solution for use with the [Spree](http://github.com/spree/spree/) E-Commerce platform.

The inspiration is found under /inspiration on the website font end. Inspiration entries have fields for title, body, summary, date published, and author. Each inspiration entry can also have categories and tags associated with it.

The [Spree Editor](http://github.com/spree/spree_editor/) extension can be used to provide a rich text experience when editing the body of a inspiration entry.

The author is an instance of `Spree.user_class`, typically a `Spree::User`. The author can be selected from users with the `inspirationger` role when editing a inspiration entry in the admin. Some additional fields, including nickname, website URL, and Google Plus URL are added to the user model. Google Authorship information is added to the page head when the Google Plus URL is set.

There is no commenting system yet. One option for adding comments is to override the `spree/inspiration_entries/comments` partial and include and external commenting system, such as [Disqus](http://disqus.com/).

Admin users can preview inspiration entries before they're made publicly visible.

This fork differs significantly from the original, it started out as a newly generated extension for Spree 1.2 with the logic copied over and tests moved to RSpec.

Screenshot
----------

This screenshot shows some example inspiration entries with the widgets in the left sidebar:

![Screenshot](https://raw.github.com/stefansenk/spree-inspiration-spree/master/screenshot.png)


Installation
------------

Add to your Gemfile:

```ruby
gem 'spree_inspiration_spree', github: 'stefansenk/spree-inspiration-spree'
```

Bundle your dependencies and run the installation generator:

```shell
    bundle install
    rake railties:install:migrations
    rake db:migrate
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_inspiration_spree/factories'
```

TODO
----

Some additional features could include:

- Allow searching for inspiration entries within the admin.
- Allow searching for inspiration entries from the shop front end.
- Get default per page from preferences.
- Allow images to be uploaded and inserted. Currently, images (other than the featured image) must be uploaded via other means.
- Add comments (including mechanisms for dealing with spam).
- Add abilities for the 'inspirationger' role, so a inspirationger can only manage their own inspiration entries within the admin.
- Add Twitter Cards meta tags.
- Add Facebook Open Graph meta tags.


Copyright (c) 2014 Stefan Senk, released under the New BSD License
