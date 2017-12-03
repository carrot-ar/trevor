# Carrot Simulator

Welcome to the Carrot simulator! This simulator is a CLI tool to simulate mobile devices connecting to and running on the Carrot framework. 

## Installation

Run `gem install carrot-sim` 

## Usage

There are several commands currently available:
`-c` `--clients N` Connect N clients to the carrot server
`-r` `--rate N` Send N requests per second to the server
`-t` `--time N` Run each client for N seconds
`-h` `--host` Sets the host to point clients to


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/carrot-ar/carrot-sim. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
