require "active_record"
require "active_excel"

conn = { adapter: "sqlite3", database: ":memory:" }
ActiveRecord::Base.establish_connection conn

class User < ActiveRecord::Base
  connection.create_table :users, force: true do |t|
    t.string :name
    t.string :email
    t.timestamp
  end

  extend ActiveExcel

  validates :name,  presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with:/.+@.+/ }
end
