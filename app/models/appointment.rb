class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :teacher, class_name: 'User'
end
