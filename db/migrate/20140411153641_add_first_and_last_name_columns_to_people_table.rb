class AddFirstAndLastNameColumnsToPeopleTable < ActiveRecord::Migration
  
  class Person < ActiveRecord::Base 
  end  
  
  def up 
    add_column :people, :first_name, :string, :after => :id  
    add_column :people, :last_name, :string, :after => :first_name
    Person.find_each do |p| 
      p.update_attribute(:first_name, "#{p.name.split[0]}")
      p.update_attribute(:last_name, "#{p.name.split[1]}") 
    end
  end   

  def down
    remove_column :people, :first_name
    remove_column :people, :last_name
  end 

end
