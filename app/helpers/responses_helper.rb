module ResponsesHelper
  def scale_options_for_answers
    options = ["Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"]
    options.map {|option| [option, option]}
  end
end

