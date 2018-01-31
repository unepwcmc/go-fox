# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.where(email: "test@test.com").first_or_create do |u|
  u.admin                 = true
  u.organisation_name     = "UNEP WCMC"
  u.username              = "Informatics"
  u.password              = "test1234"
  u.password_confirmation = "test1234"

  puts "Admin created! \nU: test@test.com\nP: test1234"
end

questions = [
  {
    text: "Humans are separate from nature, not part of it",
  },
  {
    text: "Win-win outcomes for people and nature are rarely possible",
  },
  {
    text: "Conservation will only succeed if it provides benefits for people",
  },
  {
    text: "Conserving nature for nature's sake should be a goal of conservation",
  },
  {
    text: "Conservation must benefit poor people because to do so is an ethical imperative",
  },
  {
    text: "To achieve conservation goals, the environmental impact of the world's rich must be reduced",
  },
  {
    text: "Conservation actions should primarily be informed by evidence from biological science",
  },
  {
    text: "It is acceptable for people to be displaced to make space for protected areas",
  },
  {
    text: "Pristine nature, untouched by human influences, does not exist",
  },
  {
    text: "Strict protected areas are required to achieve most conservation goals",
  },
  {
    text: "Nature often recovers from even severe perturbations",
  },
  {
    text: "Conservation goals should be based on science",
  },
  {
    text: "Protecting nature for its own sake does not work",
  },
  {
    text: "There is no significant conservation value in highly modified landscapes",
  },
  {
    text: "Conservation will only be a durable success if it has broad public support",
  },
  {
    text: "Conservation should work with, not against, capitalism",
  },
  {
    text: "Working with corporations is not just pragmatic; they can be a positive force for conservation",
  },
  {
    text: "To achieve conservation goals, human population growth must be reduced",
  },
  {
    text: "Human affection for nature grows in line with income",
  },
  {
    text: "Advancing the wellbeing of all people should be a goal of conservation",
  },
  {
    text: "Conservation should seek to reduce the emotional separation of people from nature",
  },
  {
    text: "Conservation goals should be based on ethical values",
  },
  {
    text: "Maintaining ecosystem processes should be a goal of conservation",
  },
  {
    text: "Economic arguments for conservation are risky because they can lead to unintended negative conservation outcomes",
  },
  {
    text: "Having multiple rationales for conservation weakens the conservation movement",
  },
  {
    text: "Conservation messages that emphasise the value of nature for nature's own sake are more effective than those that promote the benefits of nature to humans",
  },
  {
    text: "There is a risk that economic rationales for conservation will displace other motivations for conservation",
  },
  {
    text: "Conservation communications are more effective when they use negative 'doom and gloom' messages rather than positive messages",
  },
  {
    text: "Giving a voice to those affected by conservation actions improves conservation outcomes",
  },
  {
    text: "To achieve its goals, conservation should seek to reform global trade",
  },
  {
    text: "Non-native species offer little conservation value",
  },
  {
    text: "Human impact on nature grows in line with incomes",
  },
  {
    text: "Maintaining biological diversity should be a goal of conservation",
  },
  {
    text: "Conservation will only be a durable success if it has the support of corporations",
  },
  {
    text: "Conservation should seek to do no harm to poor people",
  },
  {
    text: "Giving a voice to those affected by conservation action is an ethical imperative",
  },
  {
    text: "The best way for conservation to contribute to human wellbeing is by promoting economic growth",
  },
  {
    text: "When communities manage their own resources, their efforts are more effective than top-down approaches",
  }
]

questions.each do |question|
  Question.where(text: question[:text]).first_or_create do |q|
    q.text = question[:text]
    puts "Created question with the text: #{question[:text]}..."
  end
end

demographic_questions = [
  {
    text: "What is your age?",
  },
  {
    text: "Select your gender?",
  },
  {
    text: "At what level is your highest completed educational qualification?",
  },
  {
    text: "Which of the following best describes your educational specialism?",
  },
  {
    text: "What is your country of nationality?",
  },
  {
    text: "Where have you done most of your work as a conservationist? Please select up to three countries.",
  },
  {
    text: "If more than three, please tell us how many countries you have worked in as a conservationist in total.",
  },
  {
    text: "In which of the following sectors have you done conservation work in your career?",
  },
  {
    text: "Do you have any substantial professional experience in a field other than conservation during your career?",
  },
  {
    text: "In which of the following sectors have you done non-conservation work in your career?",
  },
  {
    text: "Which of the following categories best describes your current professional engagement in conservation?",
  },
  {
    text: "Which of the following categories best describes the seniority of your current role within conservation?",
  },
  {
    text: "In which of the following contexts have you done significant amounts of professional conservation work?",
  },
  {
    text: "Do you have any experiences of working as a researcher or as a practitioner on market based schemes in conservation (e.g. payments for ecosystem services, taxes and subsidies, certification)?",
  },
  {
    text: "Please choose up to four of the following items that you believe have been most important in shaping your conservation values",
  },
  {
    text: "Please feel free to tell us about anything else that you think was important in shaping your values",
  },
  {
    text: "Please provide us with your email address so that we can send you summarised results and keep in contact with you about future work based on this survey.\\r\\n\\r\\nWe will not use your address for any other reason.",
  },
  {
    text: "Have you taken this survey before?",
  },
  {
    text: "Are you taking part in the WWF UK staff survey?",
  },
  {
    text: "If you are answering this as part of the WWF UK survey please choose your programme",
  },
  {
    text: "Are you taking part in the Ol Pejeta staff survey?",
  }
]

demographic_questions.each do |demographic_question|
  DemographicQuestion.where(text: demographic_question[:text]).first_or_create do |dq|
    dq.text = demographic_question[:text]
    puts "Created question with the text: #{demographic_question[:text]}..."
  end
end
