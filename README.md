# Mingle

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
  config.add_observable "Message"
end
```

You can observe any kind of model you wish. If you're lacking stuff to feed,
check out the awesome [Mingle] gem.

[Mingle]: https://github.com/hyperoslo/mingle

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
