module StaticPagesHelper
  def page_sections(page)
    t(page).map{|item| item[:link]}.to_json
  end

  def section_id(item)
    title = item[:link].gsub /[^a-zA-Z0-9 -]/, ""

    "section-#{title.gsub ' ', '-'}".downcase
  end
end
