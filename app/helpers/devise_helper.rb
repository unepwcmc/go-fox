module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    html = <<-HTML
    <div class="error_explanation">
      <p class="error_explanation">Some required information is missing or incomplete.</p>
      <p>Please review your entries and try again.</p>
      <p>If you are you trying to create an additional account please use an alternative email address.</p>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end