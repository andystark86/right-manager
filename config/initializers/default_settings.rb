
RightManager.role_foreign_key = :role_id
RightManager.user_class = "RightManager::User"

rights = []

rights << ["admin.access", "User get access to the ADMIN area"]

["customers", "documents", "users"].each do |controller|
  ["new", "create", "index", "show", "edit", "update", "destroy"].each do |action|
    rights << ["#{controller}.#{action}", "User has access to the #{controller}##{action} path"]
  end
end

RightManager.available_rights = rights