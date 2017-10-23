# create dummy roles
RightManager::Role.create(name: "Admin", description: "Role for an Admin-Account")
RightManager::Role.create(name: "Moderator", description: "Role for a Moderator-Account. Less access than an Admin.")
RightManager::Role.create(name: "PJM", description: "Project Manager")
RightManager::Role.create(name: "MM", description: "Marketing Manager")
RightManager::Role.create(name: "PJM-Trainee", description: "Trainee in Project Manager Unit")
RightManager::Role.create(name: "MM-Trainee", description: "Trainee in Marketing Unit")

# allow full access for admin-role
role = RightManager::Role.where(name: "Admin").first
RightManager::Right.all.each do |right|
  roles_right = role.roles_rights.find_or_initialize_by(right_id: right.id)
  roles_right.update_attributes(access_level: RightManager::Right::YES)
end

# create a few dummy users
all_roles = RightManager::Role.all
for i in 1..40 do
  Person.create!(first_name: "First #{i}", last_name: "Last #{i}", role: all_roles.shuffle.first)
end
