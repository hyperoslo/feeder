# Feeder

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
for your feedables (e.g. messages). All you need to do is tell Feeder what to
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
  config.observe Message, if: ->{ |message| message.show_in_feed? }
end
```

Pretty neat.

[Mingle]: https://github.com/hyperoslo/mingle

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
