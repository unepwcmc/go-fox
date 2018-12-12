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

  def b_collection_option_class(option_class)
    return "b-collection__option--#{option_class}"
  end
end
