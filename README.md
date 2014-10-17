# Feeder

[![Gem Version](https://img.shields.io/gem/v/feeder.svg?style=flat)](https://rubygems.org/gems/feeder)
[![Build Status](https://img.shields.io/travis/hyperoslo/feeder.svg?style=flat)](https://travis-ci.org/hyperoslo/feeder)
[![Dependency Status](https://img.shields.io/gemnasium/hyperoslo/feeder.svg?style=flat)](https://gemnasium.com/hyperoslo/feeder)
[![Code Climate](https://img.shields.io/codeclimate/github/hyperoslo/feeder.svg?style=flat)](https://codeclimate.com/github/hyperoslo/feeder)
[![Coverage Status](https://img.shields.io/coveralls/hyperoslo/feeder.svg?style=flat)](https://coveralls.io/r/hyperoslo/feeder)

Feeder gives you a mountable engine that provides a route to a feed page in your
Ruby on Rails application.

## Installation

Add this line to your application's Gemfile:

    gem 'feeder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feeder

Install the migrations:

    rake feeder:install:migrations

Run the migrations:

    rake db:migrate

Add the helper in your controllers:

    # app/controllers/application_controller.rb
    class ApplicationController < ActionController::Base
      helper Feeder::AuthorizationHelper
    end

## Usage

To make Feeder available, mount it to a route by adding the following somewhere
in your _config/routes.rb_:

```ruby
mount Feeder::Engine => "/feed"
```

You will now be able to display a feed on _/feed_ in your application. In order
for Feeder to display anything in your feed, however, you will need to make
views per item type in the feed. Feeder looks up these views in
_app/views/feeder/types_ by default, and then checks for a partial with the same
name as your item type. As an example, if you have a `Message` model that you
wish to list out on your feed, you would make a file called *_message.html.erb*
in _app/views/feeder/types_.

Then, all you need to do is to declare that your `Message` model is feedable:

```ruby
class Message < ActiveRecord::Base
  # If you don't want to publish every message in the feed,
  # you can provide an option: `if: -> message { message.show_in_feed? }`
  feedable
end
```

### Filtering

Want to filter out what feedables to display in your feed? We've got you covered
through the all-powerful `filter` scope! Give it a scope or model class, 
and Feeder makes sure to only return feed items with the specified feedables.
For example: say you have the following feedables:
- `ShortMessage`
- `Tweet`
- `NewsArticle`

To get `Feeder::Item`s with news articles having IDs `[1, 2, 3, 4, 5]`, tweets
from `featured` scope and all short message, you could do like this:

```ruby
Feeder::Item.filter(
  NewsArticle.where(id: [1, 2, 3, 4, 5]),
  Tweet.featured,
  ShortMessage,
)
```

**NOTE:** The `filter` scope is _exclusive_, meaning that anything you _do not_
pass in to it will also not be brought back. With the above feedables, if you
only want short messages `[1, 3, 4]`, but all of the tweets and news articles,
you would have to specify them as well, like this:

```ruby
Feeder::Item.filter(
  ShortMessage.where(id: [1, 3, 4]),
  Tweet,
  NewsArticle
)
```

The following would only return feed items with short messages:

```ruby
Feeder::Item.filter(ShortMessage)
```

### Configuration

```ruby
Feeder.configure do |config|
  # A list of scopes that will be applied to the feed items in the controller.
  config.scopes << proc { limit 5 }
end
```

You have access to the controller in the scope, which enables you to do cool
stuff like this:

```ruby
Feeder.configure do |config|
  # A list of scopes that will be applied to the feed items in the controller.
  config.scopes << proc { |ctrl| limit ctrl.params[:limit] }
end
```

If your scope evaluates to `nil` it will not be applied to prevent it from
breaking the scope chain. This enables optional paramaters by doing something
like this:

```ruby
Feeder.configure do |config|
  # A list of scopes that will be applied to the feed items in the controller.
  config.scopes << proc { |ctrl| ctrl.params.has_key?(:limit) limit(ctrl.params[:limit]) : nil }
end
```

Add this to your `spec/spec_helper.rb` if you don't want to create
`Feeder::Item` during the tests:
```ruby
Feeder.configure do |config|
  config.test_mode = true
end
```

### Stickies

You can "sticky" items in your feed so they're pinned at the top regardless of when
they were created. Just set the `sticky` attribute and Feeder will take care of the rest.

### Recommendations

You can appoint moderators to recommend exemplary items to your feed. You can configure the
conditions upon which a user is allowed to recommend items by creating an authorization adapter.

```ruby
Feeder.configure do |config|
  config.authorization_adapter = MyAuthorizationAdapter
end
```

An authorization adapter is just a class that can be initialized with a user and responds to
`authorized?` (see `Feeder::AuthorizationAdapters::Base`).

Feeder ships with an authorization adapter for CanCan. To use it, just set the `authorization_adapter`
configuration to `Feeder::AuthorizationAdapter::CanCanAdapter`. If your ability is called something
other than `Ability`, you will also want to configure `cancan_ability_class` to refer to it. If the method
to derive the current user is called something other than `current_user`, you will also want to configure
`current_user_method`.

```ruby
Feeder.configure do |config|
  config.authorization_adapter = Feeder::AuthorizationAdapters::CanCanAdapter
  config.authorization_adapter.cancan_ability_class  = 'Permission'
  config.current_user_method = 'current_author'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Hyper made this. We're a digital communications agency with a passion for good code,
and if you're using this library we probably want to hire you.


## License

Feeder is available under the MIT license. See the MIT-LICENSE file for more info.
