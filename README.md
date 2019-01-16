# ActiveExcel
ActiveExcel allows you to build ActiveRecord objects from an Excel file with validations.

Suppose you have User model and an Excel file of users data. Then you can get an array of User objects according to data in the Excel.

## Installation
In Gemfile:

```ruby
gem 'active_excel'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_excel

## Usage
Let's use this gem to User model. User model is defined as following:
```ruby
create_table "user", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
end
```

And validations is defined like this:
```ruby
class User < ApplicationRecord
  EMAIL_REGEX = /valid email regex/i

  validates :name,  presence: true
  validates :email, presence: true, format: { with: EMAIL_REGEX }
end
```

Then you can use following methods:

```ruby
active_excel = User.from_excel(excel_file)
active_excel.valid_users #=> an array of valid users
active_excel.invalid_users #=> an array of invalid users
active_excel.users #=> an array of all users
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/active_excel. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveExcel project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/active_excel/blob/master/CODE_OF_CONDUCT.md).
