module RightManager
  class UsersRight < ApplicationRecord

    belongs_to :user, class_name: RightManager.user_class.to_s, foreign_key: :user_id
    belongs_to :right

    validates :user, presence: true
    validates :right, presence: true, uniqueness: {scope: :user}

  end
end
