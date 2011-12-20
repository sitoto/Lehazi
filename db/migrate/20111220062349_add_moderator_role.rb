class AddModeratorRole < ActiveRecord::Migration
  def up
    moderator_role = Role.create(:name => 'Moderator')
    admin_user = User.find_by_login('Admin')
    admin_user.roles << moderator_role
  end

  def down
    moderator_role = Role.find_by_name(:name => 'Moderator')
    admin_user = User.find_by_login('Admin')
    admin_user.roles.delete(moderator_role)
    moderator_role.destroy
  end
end
