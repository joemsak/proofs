class SetUpFirstAdminUser < ActiveRecord::Migration
  def self.up
		#Be sure to change these settings for your initial admin user
    user = SiteUser.new
		user.login = "michael"
		user.email = APP_CONFIG['settings']['admin_email']
		user.password = "0liver!"
		user.password_confirmation = "0liver!"
    user.save(false)
		role = Role.new
		#Admin role name should be "admin" for convenience
		role.name = "admin"
		role.save
		admin_user = SiteUser.find_by_login("michael")
		admin_role = Role.find_by_name("admin")
		admin_user.activated_at = Time.now.utc
		admin_user.roles << admin_role
		admin_user.save(false)		
  end

  def self.down
		admin_user = User.find_by_login("michael")
		admin_role = Role.find_by_name("admin")
		admin_user.roles = []
    admin_user.save
    admin_user.destroy
		admin_role.destroy
  end
end
