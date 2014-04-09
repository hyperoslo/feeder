# Feeder

[![Gem Version](https://img.shields.io/gem/v/feeder.svg)](https://rubygems.org/gems/feeder)
[![Build Status](https://img.shields.io/travis/hyperoslo/feeder.svg)](https://travis-ci.org/hyperoslo/feeder)
[![Dependency Status](https://img.shields.io/gemnasium/hyperoslo/feeder.svg)](https://gemnasium.com/hyperoslo/feeder)
[![Code Climate](https://img.shields.io/codeclimate/github/hyperoslo/feeder.svg)](https://codeclimate.com/github/hyperoslo/feeder)
[![Coverage Status](https://img.shields.io/coveralls/hyperoslo/feeder.svg)](https://coveralls.io/r/hyperoslo/feeder)

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

Feeder also comes with an observer for automatically generating wrapper items
for your feedables (e.g. messages). In order to use it, you only need to register
`Feeder::FeedableObserver` into your app, which can be done in
_config/application.rb_ like this:

```ruby
config.active_record.observers = [ 'Feeder::FeedableObserver' ]
```

Then, all you need to do is tell Feeder what to
observe, which is done through an initializer, like this:

```ruby
Feeder.configure do |config|
  config.observe Message
end
```

... and declare that your `Message` model is feedable:

```ruby
class Message < ActiveRecord::Base
  feedable
end
```

If you don't want to publish every message in the feed, you can supply a condition
to `observe`:

```ruby
Feeder.configure do |config|
  config.observe Message, if: -> message { message.show_in_feed? }
end
```

Pretty neat.

### Filtering

Want to filter out what feedables to display in your feed? We've got you covered
through the all-powerful `filter` scope!  Give it a hash of feedables and the
IDs that you want to fetch, and Feeder makes sure to only return feed items with
the specified feedables. You may also pass in the symbol `:all` instead of a
list of IDs, which would fetch each of them. For example: say you have the
following feedables:

- `ShortMessage`
- `Tweet`
- `NewsArticle`

To get `Feeder::Item`s with news articles having IDs `[1, 2, 3, 4, 5]`, tweets
`[2, 4, 6, 7]` and all short message, you could do like this:

```ruby
Feeder::Item.filter(
  NewsArticle => [1, 2, 3, 4, 5],
  Tweet => [2, 4, 6, 7],
  ShortMessage => :all,
)
```

**NOTE:** The `filter` scope is _exclusive_, meaning that anything you _do not_
pass in to it will also not be brought back. With the above feedables, if you
only want short messages `[1, 3, 4]`, but all of the tweets and news articles,
you would have to specify them as well, like this:

```ruby
Feeder::Item.filter(
  ShortMessage => [1, 3, 4],
  Tweet => :all,
  NewsArticle => :all
)
```

The following would only return feed items with short messages:

```ruby
Feeder::Item.filter(ShortMessage => [1, 3, 4])
```

### Configuration

```ruby
Feeder.configure do |config|
  # A list of scopes that will be applied to the feed items in the controller.
  config.scopes << proc { limit 5 }
end
```

### Stickies

You can "sticky" messages in your feed so they're pinned at the top regardless of when
they were created. Just set the `sticky` attribute and Feeder will take care of the rest.

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
