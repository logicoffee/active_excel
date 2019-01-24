# ActiveExcel
ActiveExcel allows you to build ActiveRecord objects from an Excel file with validations.

Suppose that you have User model and an Excel file of users data. Then you can get an array of User objects according to data in the Excel.

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
Let's use this gem to the following User model.
```ruby
create_table "user", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "age"
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

### Setup
All you have to do is insert a line in the model definition.

```ruby
class User < ApplicationRecord
  extend ActiveExcel
  
end
```

Then you can use the following methods:

```ruby
validated_users = User.build_from_excel("path/to/excel/file")
validated_users.valid_records #=> an array of valid users
validated_users.invalid_records #=> an array of invalid users
validated_users.records #=> an array of all users
```

### Required Excel format

1. Sheet name should be equal to the table name
    - ActiveExcel searches by the table name.
    - There can be another sheet, which will be ignored.

1. The first row should be for the column names
    - ActiveExcel identifies each attributes from the first row.
    - There can be other columns for extra purposes.

1. There shouldn't be empty rows.
    - Even if a row seems empty, it can be actually non-empty.

Here is an example of valid format:

|  |1    |2                |3   |
|:-|:----|:----------------|:---|
|1 |name |email            |note|
|2 |Alice|alice@wonder.land|foo |
|3 |     |                 |    |
|4 |Bob  |bob@sponge.com   |bar |

It doesn't matter that there is `note` column which User model doesn't have.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/logicoffee/active_excel. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveExcel project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/logicoffee/active_excel/blob/master/CODE_OF_CONDUCT.md).
