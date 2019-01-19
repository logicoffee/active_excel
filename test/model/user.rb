require "active_record"

conn = { adapter: "sqlite3", database: ":memory:" }
ActiveRecord::Base.establish_connection conn

class User < ActiveRecord::Base
  connection.create_table :users, force: true do |t|
    t.string :name
    t.string :email
    t.timestamp
  end

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with:/.+@.+/ }
end
