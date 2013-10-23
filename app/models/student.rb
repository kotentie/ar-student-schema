require_relative '../../db/config'
#require 'sqlite3'
#$db = SQLite3::Database.new "ar-students.sqlite3"

class Student < ActiveRecord::Base
# implement your Student model here

  validates :email, format: { with: /.+@.+\..{3,6}/, message: "not a valid email" }

  validates :email, uniqueness: true

  validates_exclusion_of :birthday, in: Date.today - 3.years..Date.today, message: "you are an infant go cry"

  validates :phone, format: { with: /1?\W*([2-9][0-8][0-9])\W*([2-9][0-9]{2})\W*([0-9]{4})(\se?x?t?(\d*))?/, message: "not a valid phone number"}

  def birthday
    self[:birthday]
  end

  def name
    self[:first_name] + ' ' + self[:last_name]
  end

  def age
    now = Date.today
    age = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
  end

end

