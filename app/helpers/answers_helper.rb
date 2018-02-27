module AnswersHelper
  def format_answer(answer)
    question_type = answer.question.question_type
    array_answers = ["Checkbox", "Multiple Select Box"]

    if array_answers.include?(question_type)
      answer.raw.join(", ")
    else
      answer.raw
    end
  end
end

