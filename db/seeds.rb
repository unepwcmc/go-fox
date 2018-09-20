# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

secrets = Rails.application.secrets

user = User.where(email: secrets.admin[:admin_email]).first_or_create do |u|
  u.admin                 = true
  u.organisation_name     = secrets.admin[:admin_organisation]
  u.username              = secrets.admin[:admin_username]
  u.password              = secrets.admin[:admin_password]
  u.password_confirmation = secrets.admin[:admin_password]

  puts "Admin created! \nU: #{secrets.admin[:admin_email]}\nP: #{secrets.admin[:admin_password]}"
end

survey = Survey.where(master: true).first_or_create do |s|
  s.published = true
  s.locked    = false
  s.user_id   = user.id
  s.name      = "Master survey"

  puts "Created master survey for admin user: #{secrets.admin[:admin_email]}!"
end

F1 = "People-centred conservation"
F2 = "Scientific protectionism"
F3 = "Conservation through capitalism"

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
    axis_name: F2,
    equation_id: 3,
    text: "Conserving nature for nature's sake should be a goal of conservation",
    weight: 0.076
  },
  {
    axis_name: F1,
    equation_id: 4,
    text: "Conservation must benefit poor people because to do so is an ethical imperative",
    weight: 0.162
  },
  {
    text: "To achieve conservation goals, the environmental impact of the world's rich must be reduced",
  },
  {
    axis_name: F2,
    equation_id: 6,
    text: "Conservation actions should primarily be informed by evidence from biological science",
    weight: 0.260
  },
  {
    text: "It is acceptable for people to be displaced to make space for protected areas",
  },
  {
    text: "Pristine nature, untouched by human influences, does not exist",
  },
  {
    axis_name: F2,
    equation_id: 9,
    text: "Strict protected areas are required to achieve most conservation goals",
    weight: 0.071
  },
  {
    text: "Nature often recovers from even severe perturbations",
  },
  {
    axis_name: F2,
    equation_id: 10,
    text: "Conservation goals should be based on science",
    weight: 0.276
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
    axis_name: F3,
    equation_id: 14,
    text: "Conservation should work with not against capitalism",
    weight: 0.226
  },
  {
    axis_name: F3,
    equation_id: 15,
    text: "Working with corporations is not just pragmatic; they can be a positive force for conservation",
    weight: 0.250
  },
  {
    axis_name: F2,
    equation_id: 16,
    text: "To achieve conservation goals human population growth must be reduced",
    weight: 0.079
  },
  {
    text: "Human affection for nature grows in line with income",
  },
  {
    axis_name: F1,
    equation_id: 18,
    text: "Advancing the wellbeing of all people should be a goal of conservation",
    weight: 0.123
  },
  {
    text: "Conservation should seek to reduce the emotional separation of people from nature",
  },
  {
    axis_name: F1,
    equation_id: 20,
    text: "Conservation goals should be based on ethical values",
    weight: 0.082
  },
  {
    axis_name: F2,
    equation_id: 21,
    text: "Maintaining ecosystem processes should be a goal of conservation",
    weight: 0.119
  },
  {
    axis_name: F3,
    equation_id: 22,
    text: "Economic arguments for conservation are risky because they can lead to unintended negative conservation outcomes",
    weight: -0.083
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
    axis_name: F1,
    equation_id: 24,
    text: "Giving a voice to those affected by conservation actions improves conservation outcomes",
    weight: 0.157
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
    axis_name: F3,
    equation_id: 28,
    text: "Conservation will only be a durable success if it has the support of corporations",
    weight: 0.126
  },
  {
    axis_name: F1,
    equation_id: 29,
    text: "Conservation should seek to do no harm to poor people",
    weight: 0.142
  },
  {
    axis_name: F1,
    equation_id: 30,
    text: "Giving a voice to those affected by conservation action is an ethical imperative",
    weight: 0.232
  },
  {
    axis_name: F3,
    equation_id: 31,
    text: "The best way for conservation to contribute to human wellbeing is by promoting economic growth",
    weight: 0.096
  },
  {
    axis_name: F1,
    equation_id: 32,
    text: "When communities manage their own resources their efforts are more effective than top-down approaches",
    weight: 0.082
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

countries = ["Afghanistan", "Åland Islands", "Albania", "Algeria", "American Samoa", "Andorra", "Angola",
  "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria",
  "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin",
  "Bermuda", "Bhutan", "Bolivia, Plurinational State of", "Bonaire, Sint Eustatius and Saba", "Bosnia and Herzegovina",
  "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria",
  "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands",
  "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands",
  "Colombia", "Comoros", "Congo", "Congo, The Democratic Republic of the", "Cook Islands", "Costa Rica",
  "Côte d'Ivoire", "Croatia", "Cuba", "Curaçao", "Cyprus", "Czech Republic", "Denmark", "Djibouti",
  "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea",
  "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France",
  "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia",
  "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam",
  "Guatemala", "Guernsey", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard Island and McDonald Islands",
  "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia",
  "Iran, Islamic Republic of", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan",
  "Jersey", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of",
  "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic", "Latvia", "Lebanon",
  "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macao",
  "Macedonia, Republic of", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands",
  "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of",
  "Moldova, Republic of", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar",
  "Namibia", "Nauru", "Nepal", "Netherlands Antilles", "Netherlands", "New Caledonia", "New Zealand",
  "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman",
  "Pakistan", "Palau", "Palestine, State of", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines",
  "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Réunion", "Romania", "Russian Federation",
  "Rwanda", "Saint Barthélemy", "Saint Helena, Ascension and Tristan da Cunha", "Saint Kitts and Nevis",
  "Saint Lucia", "Saint Martin (French part)", "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines",
  "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles",
  "Sierra Leone", "Singapore", "Sint Maarten (Dutch part)", "Slovakia", "Slovenia", "Solomon Islands",
  "Somalia", "South Africa", "South Georgia and the South Sandwich Islands", "South Sudan", "Spain",
  "Sri Lanka", "Sudan", "Suriname", "Svalbard and Jan Mayen", "Swaziland", "Sweden", "Switzerland",
  "Syrian Arab Republic", "Taiwan", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Timor-Leste",
  "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan",
  "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom",
  "United States Minor Outlying Islands", "United States", "Uruguay", "Uzbekistan", "Vanuatu",
  "Venezuela, Bolivarian Republic of", "Viet Nam", "Virgin Islands, British", "Virgin Islands, U.S.",
  "Wallis and Futuna", "Western Sahara", "Yemen", "Zambia", "Zimbabwe"]

demographic_questions = [
  {
    text: "What is your age?",
    question_type: "Free Text",
    required: false
  },
  {
    text: "Select your gender?",
    options: ["Male", "Female", "Other", "Prefer not to say"],
    question_type: "Radio button",
    required: true
  },
  {
    text: "At what level is your highest completed educational qualification?",
    options: ["School level",
              "Post-high school, but at an institution other than a university",
              "Undergraduate/bachelors university degree",
              "Masters degree/postgraduate qualification",
              "Doctorate",
              "Not applicable"],
    question_type: "Radio button",
    required: true
  },
  {
    text: "Which of the following best describes your educational specialism?",
    options: ["Biological sciences (e.g. zoology, plant sciences)",
              "Non-biological natural sciences (e.g. chemistry, maths, engineering)",
              "Social sciences (e.g. economics, human geography, political science)",
              "Humanities (e.g. literature, history, philosophy, languages)",
              "Interdisciplinary (a combination of at least two of natural science, social science and humanities)",
              "Not applicable"],
    question_type: "Radio button",
    required: true
  },
  {
    text: "What is your country of nationality?",
    options: countries,
    question_type: "Select box",
    required: false
  },
  {
    text: "Where have you done most of your work as a conservationist? Please select up to three countries.",
    options: countries,
    question_type: "Multiple Select Box",
    required: false
  },
  {
    text: "If more than three, please tell us how many countries you have worked in as a conservationist in total.",
    question_type: "Free Text",
    required: false
  },
  {
    text: "In which of the following sectors have you done conservation work in your career?",
    options: ["Academia/educational institution",
              "Not for profit/non governmental organisation",
              "Private sector",
              "Government",
              "Other",
              "Not applicable"],
    question_type: "Checkbox",
    required: true
  },
  {
    text: "Do you have any substantial professional experience in a field other than conservation during your career?",
    options: ["Yes", "No", "Not applicable"],
    question_type: "Radio button",
    required: true
  },
  {
    text: "In which of the following sectors have you done non-conservation work in your career?",
    options: ["Academia/educational institution",
              "Not for profit/non governmental organisation",
              "Private sector",
              "Government",
              "Other",
              "Not applicable"],
    question_type: "Checkbox",
    required: true
  },
  {
    text: "Which of the following categories best describes your current professional engagement in conservation?",
    options: ["Exclusively a researcher",
             "Mostly a researcher",
             "Both a researcher and practitioner",
             "Mostly a practitioner",
             "Exclusively a practitioner",
             "Not applicable"],
    question_type: "Radio button",
    required: true
  },
  {
    text: "Which of the following categories best describes the seniority of your current role within conservation?",
    options: ["Very junior position",
              "Fairly junior position",
              "Neither senior nor junior position",
              "Fairly senior position",
              "Very senior position",
              "I am not currently working in conservation"],
    question_type: "Radio button",
    required: true
  },
  {
    text: "In which of the following contexts have you done significant amounts of professional conservation work?",
    options: ["Very heavily modified ecosystems (e.g. urban areas)",
              "Largely modified ecosystems (e.g. intensive farmland, intensive fisheries)",
              "Somewhat modified ecosystems (e.g. low intensity farmland, low intensity fisheries)",
              "Largely unmodified ecosystems (e.g. sustainable use area)",
              "Unmodified or very little modified ecosystem (e.g. wilderness areas)",
              "Other",
              "Not applicable"],
    question_type: "Checkbox",
    required: true
  },
  {
    text: "Do you have any experiences of working as a researcher or as a practitioner on market based schemes in conservation (e.g. payments for ecosystem services, taxes and subsidies, mitigation or species banking, certification)?",
    options: ["Yes, as a researcher",
              "Yes, as a practitioner",
              "Yes, both as a researcher and as a practitioner",
              "No"],
    question_type: "Radio button",
    required: true
  },
  {
    text: "Please choose up to four of the following items that you believe have been most important in shaping your conservation values",
    options: ["Values of family and friends during childhood",
              "Values of family and friends during adulthood",
              "Outdoor play/recreation during childhood",
              "Outdoor play/recreation during adulthood",
              "Indoor experiences (e.g. reading books, watching documentaries, playing video games) during childhood",
              "Indoor experiences (e.g. reading books, watching documentaries, playing video games) during adulthood",
              "Formal education experience (e.g. field trip, classroom session) during childhood",
              "Formal education experience (e.g. field trip, classroom session) during adulthood",
              "Professional experience during adulthood",
              "None of the above",
              "Not applicable"],
     question_type: "Checkbox",
     required: true
  },
  {
    text: "Please feel free to tell us about anything else that you think was important in shaping your values",
    question_type: "Free Text",
    required: false
  },
  {
    text: "Please provide us with your email address so that we can send you summarised results and keep in contact with you about future work based on this survey. We will not use your address for any other reason.",
    question_type: "Free Text",
    required: false
  },
  {
    text: "Have you taken this survey before?",
    options: ["Yes", "No"],
    question_type: "Radio button",
    required: true
  },
  {
    text: "If there are any issues which you think are relevant to debates about the future of conservation, which were not included in this survey, please briefly outline them below. We intend to incorporate new statements into the survey in the future, so your suggestions are very welcome.",
    question_type: "Free Text",
    required: false
  },
]

demographic_questions.each do |demographic_question|
  question  = DemographicQuestion.find_or_create_by(text: demographic_question[:text]) do |dq|
                dq.question_type = demographic_question[:question_type]
                dq.validation = {
                  required: demographic_question[:required]
                }.to_json
                puts "+ Adding demographic question..."
                puts demographic_question[:text]
              end


  # Add options for question if they don't exist
  if demographic_question[:options]
    demographic_question[:options].each do |option|
      Option.where(text: option, optionable_id: question, optionable_type: "DemographicQuestion").first_or_create
      puts "\t- #{option}"
    end
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
  Classification.where(name: classification[:name]).first_or_create do |c|
    c.description         = classification[:description]
    c.results_description = classification[:results_description]

    puts "+ Created Classification: #{classification[:name]}"
  end
end
