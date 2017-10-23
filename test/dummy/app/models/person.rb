class Person < ApplicationRecord
  include RightManager::Concerns::Roleable


  validates :first_name, presence: true
  validates :last_name, presence: true

  def right_manager_display_value
    first_name.to_s + ' ' + last_name.to_s
  end
end
