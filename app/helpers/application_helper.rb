module ApplicationHelper
  def resource_name
    current_user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def current_class?(test_path)
    request.fullpath == test_path ? ' nav--active' : ''
  end

  def is_current_page?(test_path)
    request.fullpath == test_path
  end
end
