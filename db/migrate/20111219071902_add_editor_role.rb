class AddEditorRole < ActiveRecord::Migration
  def up
    editor_role = Role.create(:name => 'Editor')
    admin_user = User.find_by_login('Admin')
    admin_user.roles << editor_role
  end

  def down
    editor_role = Role.create(:name => 'Editor')
    admin_user = User.find_by_login('Admin')
    admin_user.roles.delete(editor_role)
    editor_role.destroy
  end
end
