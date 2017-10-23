
 namespace :right_manager do
   desc "Create or Update Rights in the Database depending on your Right configuration"
   task :update_rights => :environment do

     #create new rights
     ::RightManager.available_rights.each do |right_setting|
       name = right_setting[0]
       description = right_setting[1]
       group_name = right_setting[2]

       right = RightManager::Right.where("LOWER(name) = ?", name.to_s.downcase).first
       group = RightManager::Group.where("LOWER(name) = ?", group_name.to_s.downcase).first

       if group_name.present? && group.blank?
         group = RightManager::Group.create!(name: group_name)
         p "Group created: #{group_name}"
       end

       unless right
         RightManager::Right.create!(name: name, description: description, group: group)
         p "Right created: #{name}"
       else
         if right.group != group
           right.update(group: group)
           p "Group of Right updated: #{name}=>#{group ? group.name : "nil"}"
         end
       end
     end

     #destroy removed rights
     ::RightManager::Right.all.each do |right|
       unless RightManager.available_rights.select{|r| r.first.to_s.downcase == right.name.to_s.downcase}.present?
         right.destroy
         p "Right destroyed: #{right.name}"
       end
     end


   end
 end
