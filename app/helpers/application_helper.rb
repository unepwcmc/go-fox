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

  def current_page
    request.fullpath
  end

  def encoded_base_url
    url_encode(request.base_url)
  end

  def current_class?(test_path)
    current_page == test_path ? ' nav--active' : ''
  end

  def is_current_page?(test_path)
    current_page == test_path
  end

  def create_social_facebook_link
    title = url_encode('Share your results on Facebook')
    url = encoded_base_url
    href = 'https://facebook.com/sharer/sharer.php?u=' + url

    link_to '', href, title: title, class: 'icon--social icon--facebook', target: '_blank'
  end

  def create_social_twitter_link
    title = url_encode('Share your results on Twitter')
    text = url_encode('What kind of conservationist are you? Take the Future of Conservation survey to find out #FutureOfConservation')
    url = encoded_base_url
    href = 'https://twitter.com/intent/tweet/?text=' + text + '&url=' + url
    
    link_to '', href, title: title, class: 'icon--social icon--twitter', target: '_blank'
  end

  def create_social_email_link
    title = url_encode('Share your results via Email')
    url = encoded_base_url
    subject = url_encode('What kind of conservationist are you? Take the Future of Conservation survey to find out #FutureOfConservation')
    body = url_encode("\n\n") + url
    href = 'mailto:?subject=' + subject + '&body=' + body

    link_to '', href, title: title, class: 'icon--social icon--mail', target: '_self'
  end

  def b_collection_option_class(option_class)
    return "b-collection__option--#{option_class}"
  end
end
