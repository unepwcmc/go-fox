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

  def social_urls
    {
      facebook: 'https://www.facebook.com',
      twitter: 'https://www.twitter.com'
    }
  end

  def create_social_link(site)
    title = url_encode("Follow Go Fox on #{site}")
    href = social_urls[site.downcase.to_sym]

    link_to '', href, title: title, class: "icon--social icon--#{site.downcase}", target: '_blank'
  end
end
