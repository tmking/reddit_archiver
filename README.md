# RedditArchiver

**RedditArchiver** is a simple command line tool that will retrieve the contents of a reddit account, up to reddit's hard limit of 1000 items. This means that if your account contains a total of 1001 submissions or comments, only 1000 of them can be retrieved. There is currently no way around this limit.

## Installation

Add this line to your application's Gemfile:

    gem 'reddit_archiver'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reddit_archiver

## Usage

    $ mv config.yml.example config.yml

Edit the configuration file to supply your account details. Then, run

    $ bundle exec reddit_archiver

Once the script finishes, your posts will be available in the directory specified in config.yml.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
