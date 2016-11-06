#ActiveRecord::Base.connection.tables.each do |table|
#  ActiveRecord::Base.connection.reset_pk_sequence! table
#end

AdminUser.first_or_create!(email: 'andrey.chernih@gmail.com', password: '17087561', password_confirmation: '17087561')
user = User.first_or_create!(email: 'andrey.chernih@gmail.com', password: '17087561', password_confirmation: '17087561', first_name: 'Andrey', last_name: 'Chernih')

course1 = Course.find_or_initialize_by code: 'WEB1'
course1.update_attributes! name: 'Automating Web Applications',
                           price_cents: 3900,
                           level: 'beginning',
                           completion_time_hours: 14,
                           description: <<-EOT
This course will teach you how to create automated end to end scenarios for testing Web applications. We will use <strong>Cucumber</strong>
to write feature files describing application business logic and implement code for testing this logic using <strong>Ruby</strong> and
<strong>Selenium WebDriver</strong>. You will learn how to configure Cucumber project and interact with the browser using <strong>CSS</strong>
and <strong>XPATH</strong> selectors. Course includes various interactive exercises which will help to reinforce the material. At the end of this
course you will be able to automate web-applications by yourself.
EOT
course1.update_attributes! requirements: <<-EOT
This course is for people with basic technical knowledge. You don't need to know Ruby, Cucumber or Selenium, but basic knowledge of HTML
is recommended. You don't need to have development environment for taking this course because all assignments are running inside browser, but it's highly
recommended to install Ruby and to try to run code examples on your local computer.
EOT

position = 1
[
  { name: 'Ruby', code: 'ruby' },
  { name: 'Cucumber', code: 'cucumber' },
  { name: 'Selenium WebDriver', code: 'selenium' }
].each do |attrs|
  attrs[:position] = position
  section = course1.sections.find_or_initialize_by code: attrs[:code]
  section.update_attributes! attrs
  position += 1
end

position = 1
[

  #
  # Ruby
  #

  { name: 'Installation',
    section: 'ruby',
    code: 'installation',
    content_type: :text,
    description: 'Ruby installation instructions for Mac OS X, Windows and Linux.' },

  { name: 'Introduction',
    section: 'ruby',
    code: 'introduction',
    content_type: :text,
    description: 'Introduction into programming in Ruby. Variables, arrays and hashes.' },

  { name: 'Conditions',
    section: 'ruby',
    code: 'conditions',
    content_type: :text,
    description: 'if / else / elsif / case / unless conditional statements.' },

  { name: 'Blocks and loops',
    section: 'ruby',
    code: 'blocks_and_loops',
    content_type: :text,
    description: 'Teaches how to iterate over array.' },

  { name: 'Regular expressions',
    section: 'ruby',
    code: 'regular_expressions',
    content_type: :text,
    description: 'How to search through text for a given pattern.' },

  { name: 'Objects and methods',
    section: 'ruby',
    code: 'objects_and_methods',
    content_type: :text,
    description: 'Described how to define new class and create new object.' },

  #
  # Cucumber
  #

  { name: 'Introduction',
    section: 'cucumber',
    is_demo: true,
    code: 'introduction',
    content_type: :text,
    description: 'Brief introduction into cucumber. Features and step definitions. Project setup.' },

  { name: 'Gherkin',
    section: 'cucumber',
    is_demo: true,
    code: 'gherkin',
    content_type: :text,
    description: 'Chapter about Gherkin language which is used in cucumber to write features and scenarios. Given, When, Then keywords explained.' },

  { name: 'Exercise: Create scenario',
    section: 'cucumber',
    is_demo: true,
    code: 'exercise_create_scenario',
    content_type: :exercise,
    description: 'Create scenario to test addition of numbers.' },

  { name: 'Step definitions',
    section: 'cucumber',
    code: 'step_definitions',
    content_type: :text,
    description: 'How to write step definitions - the drivers of cucumber scenarios.' },

  { name: 'Exercise: Create step definition',
    section: 'cucumber',
    code: 'exercise_cucumber_create_step_definition',
    content_type: :exercise,
    description: 'Create your first step definition.' },

  { name: 'Code reusability - calling other steps',
    section: 'cucumber',
    code: 'code_reusability',
    content_type: :text,
    description: 'Use step and steps cucumber command to achieve code reusability' },

  { name: 'Exercise: Call other steps from step',
    section: 'cucumber',
    code: 'exercise_call_other_steps_from_step',
    content_type: :exercise,
    description: 'Create higher level step definition by calling other step.' },

  { name: 'Extracting common steps into Background section',
    section: 'cucumber',
    code: 'background',
    content_type: :text,
    description: 'Learn how to refactor scenarios by extracting shared setup steps into Background section.' },

  { name: 'Exercise: Refactor feature',
    section: 'cucumber',
    code: 'exercise_refactor',
    content_type: :exercise,
    description: 'DRY feature scenarios by adding Background section with common steps.' },

  { name: 'Scenario Outline - templates for repetitive test cases',
    section: 'cucumber',
    code: 'scenario_outline',
    content_type: :text,
    description: 'You may use Scenario Outline to create test templates for your scenarios.' },

  { name: 'Exercise: Create scenario outline',
    section: 'cucumber',
    code: 'exercise_create_scenario_outline',
    content_type: :exercise,
    description: 'Refactor feature so that instead of many scenarios we only have 1 template and a set of example values.' },

  { name: 'Tables',
    section: 'cucumber',
    code: 'tables',
    content_type: :text,
    description: 'Table is a cucumber object which can be passed to steps.' },

  { name: 'Exercise: Subtraction table',
    section: 'cucumber',
    code: 'exercise_subtraction_table',
    content_type: :exercise,
    description: 'Implement step definitions for testing operation of subtraction' },


  #
  # Selenium
  #

  { name: 'Introduction',
    section: 'selenium',
    code: 'introduction',
    content_type: :text,
    description: 'Introduction to Selenium WebDriver.' },

  { name: 'Exercise: Reveal secret message',
    section: 'selenium',
    code: 'exercise_reveal_secret_message',
    content_type: :exercise,
    description: 'First exercise in this course. You need to automate web app which shows secret message.' },

  { name: 'Controlling browser with Selenium WebDriver',
    section: 'selenium',
    code: 'controlling_browser',
    content_type: :text,
    description: 'Introduction how to Selenium WebDriver. Explanation how to open and close browser using Selenium WebDriver.' },

  { name: 'Visiting website pages',
    section: 'selenium',
    code: 'visiting_website_pages',
    content_type: :text,
    description: 'Navigating through the website using Selenium WebDriver. Opening pages directly and clicking links.' },

  { name: 'Sample project: Visit google.com',
    section: 'selenium',
    code: 'sample_visit_google',
    content_type: :text,
    description: 'Create sample project to visit google.com using Cucumber and Selenium WebDriver libraries.' },

  { name: 'Exercise: Go to the sign in page',
    section: 'selenium',
    code: 'exercise_go_to_sign_in_page',
    content_type: :exercise,
    description: 'You will need to create 3 step definitions to open Sign In page in browser.' },

  { name: 'HTML, CSS and XPATH',
    section: 'selenium',
    code: 'html_css_xpath',
    content_type: :text,
    description: 'Introduction into HTML, CSS and XPATH and how to discover elements using browser developer tools.' },

  { name: 'Locating HTML elements',
    section: 'selenium',
    code: 'locating_html_elements',
    content_type: :text,
    description: 'How to programmatically find HTML elements using various selectors.' },

  { name: 'Verifying outcome',
    section: 'selenium',
    code: 'verifying_outcome',
    content_type: :text,
    description: 'Check that page includes some text when you need to verify some outcome.' },

  { name: 'Exercise: Create step definition',
    section: 'selenium',
    code: 'exercise_create_step_definition',
    content_type: :exercise,
    description: 'Create your own step definition to go to the registration form.' },

  { name: 'Exercise: Defuse bomb',
    section: 'selenium',
    code: 'exercise_defuse_bomb',
    content_type: :exercise,
    description: 'Use correct element selector to click the right button to defuse the bomb.' },

  { name: 'Filling in forms',
    section: 'selenium',
    code: 'filling_in_forms',
    content_type: :text,
    description: 'Interacting with the web page - filling in values for various input types' },

  { name: 'Exercise: Create an account',
    section: 'selenium',
    code: 'exercise_create_account',
    content_type: :exercise,
    description: 'Use registration form to create new account on the website.' },

  { name: 'Exercise: Test negative case',
    section: 'selenium',
    code: 'exercise_test_negative_case',
    content_type: :exercise,
    description: 'Automate registration form for negarive test case - when password confirmation does not match password.' },

  { name: 'Implicit and explicit waits',
    section: 'selenium',
    code: 'waiting_for_elements',
    content_type: :text,
    description: 'How to handle dynamically loaded content and when web app is slow.' },

  { name: 'Exercise: Wait for element to appear',
    section: 'selenium',
    code: 'exercise_wait_for_element',
    content_type: :exercise,
    description: 'Use an explicit way of waiting element to appear on the webpage.' },

].each do |attrs|
  section = course1.sections.find_by_code!(attrs.delete(:section))

  attrs[:position] = position
  attrs[:section_id] = section.id

  chapter = section.chapters.find_or_initialize_by code: attrs[:code]
  chapter.course = course1
  chapter.update_attributes! attrs
  position += 1
end

course1.cheatsheets.destroy_all
course1.cheatsheets.create! code: 'cheatsheet'
course1.cheatsheets.create! code: 'ruby'
course1.cheatsheets.create! code: 'git'
course1.cheatsheets.create! code: 'regexp'
course1.cheatsheets.create! code: 'linux'
course1.cheatsheets.create! code: 'cucumber'
course1.cheatsheets.create! code: 'selenium'

task = Tasks::Courses::UnlockChapters.new(course: course1.reload, user: user)
task.run

#UserCourse.create! user: user, course: course1
