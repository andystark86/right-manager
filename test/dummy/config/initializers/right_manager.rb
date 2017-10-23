require 'right_manager'

RightManager.role_foreign_key = :access_role_id
RightManager.user_class = "Person"

rights = []

rights << ["admin.access", "User get access to the ADMIN area", "Special"]
rights << ["secrets.index", "User get access to the secrete section of your app", "Special"]
rights << ["test-user", "only for testing stuff"]

["customers", "documents", "users", "projects", "campaigns"].each do |controller|
  ["create", "index", "show", "update", "destroy", "copy", "export_list"].each do |action|
    rights << ["#{controller}.#{action}", "User has access to the '#{controller}##{action}' path", controller.upcase_first + "-(controller actions)"]
  end
end

["customers", "documents", "users", "projects", "campaigns"].each do |controller|
  ["edit_name", "update_history_panel", "comment_field"].each do |action|
    rights << ["#{controller}.view.#{action}", "User can see or do '#{action}'", controller.upcase_first + "-(view template switches)"]
  end
end

RightManager.available_rights = rights