# RightManager
Rails Engine for a database driven access management.

## Features
* Bootstrap3 UI for managing your roles
* Configuration of the rights for every role
* Grant or revoke rights for single users independent of the users role 

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'right_manager', git: 'https://github.com/andystark86/right-manager'
```

And then execute:
```bash
$ bundle install
```

Copy and migrate migrations
```bash
$ rake right_manager:install:migrations
$ rake db:migrate
```

Create an initializer and configure your available rights
```ruby
# /config/initializers/right_manager.rb
require 'right_manager'

#Set the ActiveRecord model name of your main app that has the role-relation (e.g. Person, User, Employee,...)
RightManager.user_class = "Person"

#You can also configure the foreign key for the role-relation of your main apps model. 
#Default RightManager expects a :role_id-column
RightManager.role_foreign_key = :role_id


#You have to configure all available rights in your initializer
#The configuration schema is: 
#[right-name, description (optional), group-name (optional)]  

rights = []
rights << ["admin.access", "User get access to the ADMIN area", "Special"]
  
["customers", "documents", "projects"].each do |controller|
  ["create", "index", "show", "update", "destroy", "copy"].each do |action|
    rights << ["#{controller}.#{action}", "User has access to the #{controller}##{action} path", "Controller-Rights"]
  end
end
  
RightManager.available_rights = rights
```

Import the rights configurations into the database
```bash
$ rake right_manager:update_rights
```

Mount the RightManager into your main App
```ruby
# /config/routes.rb
mount RightManager::Engine => "/right_manager"
```

Include the neccessary Mixin in your User-Class
```bash
class Person < ApplicationRecord
  include RightManager::Concerns::Roleable
  
  #RightManager needs this method for the users list
  def right_manager_display_value
    first_name.to_s + ' ' + last_name.to_s
  end
    
end
```

Start your main app and test RightManager in your browser
```bash
 https://localhost:3000/right_manager/
```
## Usage
How to use RightManager.
```ruby
Person.find(1234).can?('admin.access')
=> returns true or false
```
```ruby
Person.find(1234).can!('admin.access')
=> returns true or throws a RightManager::NoAccess-Error
```

#### Changing your right configuration
You can't create or delete rights in the UI!

You always have to change the `available_rights` in your RightManager initializer
and execute the `rake right_manager:update_rights` task.

This task:
* Creates a new right-record if the `right-name` isn't in the database yet.
* **DELETES ALL** right-records that are in the database but not in your `available_rights` array.
* Creates a new group-record if the `group-name` isn't in the database yet and connect the right-record with the group.
* Removes or change the group relation of a right-record if you remove or change the `group-name` in the initializer.
* Does not delete any groups. You can do that in the UI.

## Developing and Testing
Download or fork the RightManager project
```bash
$ cd right_manager/test/dummy
$ bundle install
$ rake db:migrate
$ rake right_manager:update_rights
$ rake db:seed
$ rails server
```

and go to
```bash
https://localhost:3000
```
The dummy project has a `Person`-Model with a scaffolded CRUD-UI implemented. It has links to switch between dummy (main app) and the RightManager plugin.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
