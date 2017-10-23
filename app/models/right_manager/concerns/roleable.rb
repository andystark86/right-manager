module RightManager
  module Concerns
    module Roleable

      extend ActiveSupport::Concern

      included do
        belongs_to :role, foreign_key: RightManager.role_foreign_key, class_name: RightManager::Role.name

        has_many :users_rights, class_name: RightManager::UsersRight.name, foreign_key: :user_id, dependent: :destroy
        has_many :rights, class_name: RightManager::Right.name, through: :users_rights
        accepts_nested_attributes_for :users_rights, allow_destroy: true, reject_if: :default_value

        validates :role, presence: true

      end

      class_methods do

      end

      def can?(right_name)
        right = RightManager::Right.where("LOWER(name) = ?",right_name.to_s.downcase).first
        raise RightManager::Error, "Unknown right '#{right_name}'!" unless right

        right_of_user = users_rights.where(right_id: right.id).first
        if right_of_user.blank? || right_of_user.access_level == ::RightManager::Right::ACCESS_OF_ROLE
          right_of_user = role.roles_rights.where(right_id: right.id).first
        end

        right_of_user.try(:access_level) == RightManager::Right::YES
      end

      def can!(right_name)
        raise RightManager::NoAccess, right_name unless can?(right_name)
        true
      end

      def right_manager_display_value
        raise "Abstract method ´#{__method__}´ called. Implement this instance method in your #{self.class.name}-class."
      end


      protected

      # default value is always RightManager::Right::ACCESS_OF_ROLE
      # so we save only users<-->rights access_level YES or NO combinations
      def default_value(attributes)
        exists = attributes['id'].present?
        obsolete = attributes['access_level'].to_i == RightManager::Right::ACCESS_OF_ROLE
        attributes[:_destroy] = 1 if exists && obsolete # destroy default access levels
        return (!exists && obsolete) # reject default access levels
      end

    end
  end

end