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
    # for development only generate random x,y,z weights
    if Rails.env == 'development'
      q.x_weight = rand(-1.0...1.0)
      q.y_weight = rand(-1.0...1.0)
      q.z_weight = rand(-1.0...1.0)
    end
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
    puts "Created question with the text: #{demographic_question[:text]}..."
  end
end

classifications = [
  {
    name: "Critical Social Science",
    description: "According to critical social scientists, the impacts of conservation on human wellbeing should be at the forefront of the conservation debate. This entails both being critical of negative side-effects that conservation activities might have on people who are economically poor and/or politically marginalised, and also employing conservation initiatives as a means of improving human welfare. However, critical social scientists tend to be sceptical of the ability of markets and capitalism to deliver benefits for both nature and people. For example, the economic valuation of nature might be perceived as a corporate strategy to open up avenues for its exploitation, whilst concealing the negative impacts of such activities by manipulating the way in which these activities are presented to the public. This position is sometimes critiqued by others for offering a strong diagnosis of what is wrong with conservation practice, whilst failing to offer practical alternatives.",
    results_description: "Your position on the two axes above reflects your survey answers. A move from left to right along the horizontal axis (people & nature) implies a shift from seeing conservation as a means of improving human welfare to conservation for nature’s own sake. The vertical axis (capitalism & conservation) indicates a spectrum of willingness to embrace markets and capitalism as conservation tools: the higher up the graph your score is, the more pro-markets it is. This places you in the bottom left quadrant of the graph – a position suggesting your views on these particular dimensions of the debate are most closely related to those of what we call ‘critical social science’."
  },
  {
    name: "Market Biocentrism",
    description: "Support for an intrinsic value-based rationale for conservation along with a market-based approach to achieving conservation goals is not common in the existing literature. Perhaps one example of such ‘market biocentrism’ is EO Wilson’s recent book ‘Half-Earth’, which advocates the setting aside of half of the Earth’s surface for nature reserves. Aware that this ambitious target would require a drastic decrease in per capita environmental footprint worldwide, Wilson advocates free markets as a means to favour those products which yield the maximum profit for the minimum energy and resource consumption. However, Wilson’s pro-markets view seems to be more to do with ensuring that humanity can flourish on only 50% of the Earth’s surface rather than as a tool for carrying out conservation: that is, the pro-market strategy would be used to buffer the ‘human’ half of the Earth against the need to exploit the ‘natural’ half, rather than as a means to create economic value from protecting the ‘natural’ half.",
    results_description: "Your position on the two axes above reflects your survey answers. A move from left to right along the horizontal axis (people & nature) implies a shift from seeing conservation as a means of improving human welfare to conservation for nature’s own sake. The vertical axis (conservation & capitalism) indicates a spectrum of willingness to embrace markets and capitalism as conservation tools: the higher up the graph your score is, the more pro-markets it is. This places you in the top right quadrant of the graph – a position suggesting your views on these particular dimensions of the debate are most closely related to those of what we call ‘market biocentrism’."
  },
  {
    name: "New Conservation",
    description: "Central to the ‘new conservation’ position is a shift towards framing conservation as being about protecting nature in order to improve human wellbeing (especially that of the poor), rather than for biodiversity’s own sake. ‘New conservationists’ believe that win-win situations in which people benefit from conservation can often be achieved by promoting economic growth and partnering with corporations. Although new conservation advocates have been criticised for doing away with nature’s intrinsic value, key authors within the movement have responded by clarifying that their motive is not so much an ethical as a strategic or pragmatic one. In other words, they claim that conservation needs to emphasise nature’s instrumental value to people because this better promotes support for conservation compared to arguments based solely on species’ rights to exist.",
    results_description: "Your position on the two axes above reflects your survey answers. A move from left to right along the horizontal axis (people & nature) implies a shift from seeing conservation as a means of improving human welfare to conservation for nature’s own sake. The vertical axis (conservation & capitalism) indicates a spectrum of willingness to embrace markets and capitalism as conservation tools: the higher up the graph your score is, the more pro-markets it is. This places you in the top left quadrant of the graph – a position suggesting your views on these particular dimensions of the debate are most closely related to those of ‘new conservationists’ as set out in the literature."
  },
  {
    name: "Traditional Conservation",
    description: "Traditional conservationists often support the protection of nature for its own sake. This emphasis on nature’s intrinsic value typically leads traditional conservation advocates to be critical of markets and economic growth as tools for conservation. This is because they believe that by embracing markets, we run the risk of ‘selling out nature’ by neglecting species that may be considered to be of little economic value. What’s more, economic growth itself is seen as a major driver of threats to biodiversity. Traditional conservationists often defend their position by claiming that there is nothing new in ‘new conservation’, noting for example that conservation has for a long time kept human wellbeing in mind and tried to minimise any negative impacts it may have had on local communities. Traditional conservationists typically favour protected areas, particularly in ecosystems with relatively low human impacts, as a primary conservation strategy.",
    results_description: "Your position on the two axes above reflects your survey answers. A move from left to right along the horizontal axis (people & nature) implies a shift from seeing conservation as a means of improving human welfare to conservation for nature’s own sake. The vertical axis (conservation & capitalism) indicates a spectrum of willingness to embrace markets and capitalism as conservation tools: the higher up the graph your score is, the more pro-markets it is. This places you in the bottom right quadrant of the graph – a position suggesting your views on these particular dimensions of the debate are most closely related to those of what we call ‘traditional conservation’."
  },
  {
    name: "Undecided",
    description: "You are undecided",
    results_description: "Your position on the two axes above reflects your survey answers. A move from left to right along the horizontal axis (people & nature) implies a shift from seeing conservation as a means of improving human welfare to conservation for nature’s own sake. The vertical axis (conservation & capitalism) indicates a spectrum of willingness to embrace markets and capitalism as conservation tools: the higher up the graph your score is, the more pro-markets it is. This places you in the centre of the graph – a position suggesting your views on these particular dimensions of the debate are most closely shared between all areas."
  }
]

classifications.each do |classification|
  cls = Classification.where(name: classification[:name]).first_or_create do |c|
    c.description = classification[:description]
    c.results_description = classification[:results_description]
    puts "Created classification with the name: #{classification[:name]}..."
  end

  # If there is a change from the saved record, update it
  unless cls.description == classification[:description] ||
    cls.results_description == classification[:results_description] ||
    cls.name == classification[:name]

    cls.update_attributes(
      name:                 classification[:name],
      description:          classification[:description],
      results_description:  classification[:results_description]
    )
  end
end
