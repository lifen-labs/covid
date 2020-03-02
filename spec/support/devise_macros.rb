module DeviseMacros
  def admin_sign_in_with(admin_user)
    login_as(admin_user, scope: :admin_user)
  end
end

RSpec.configure do |config|
  config.include(DeviseMacros)
end
