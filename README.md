*This gem is currently in development*
TODO: Add error handling.

[![Code Climate](https://codeclimate.com/github/soccerbrain/telstra-sms/badges/gpa.svg)](https://codeclimate.com/github/soccerbrain/telstra-sms)
[![Build Status](https://travis-ci.org/soccerbrain/telstra-sms.svg)](https://travis-ci.org/soccerbrain/telstra-sms)

# Telstra::Sms

Ruby gem for the Telstra SMS API at https://dev.telstra.com

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'telstra-sms'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install telstra-sms

## Usage

```ruby
  t = Telstra::SMS.new(consumer_key, consumer_secret)
  t.send_sms(to: "04XX XXX XXXX", body: 'Hello from Telstra!')
  t.get_message_status(message_id)
  t.get_message_response(message_id)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/telstra-sms/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
