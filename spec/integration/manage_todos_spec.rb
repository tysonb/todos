require 'spec_helper'

# We don't really want to interact with the database with our
# integrations tests.  These are tests that are supposed to 
# assert that a user can perform some interaction
# and make sure they saw that interaction work successfully.
# They're not going to be able to touch DB in a direct manner.
# They will be looking for content on the page.

feature 'Manage todos' do
  scenario 'create a new todo' do
    sign_in

    create_todo_with_description 'Buy some milk'
    user_sees_todo_item 'Buy some milk'
  end

  scenario 'view only my todos' do
    # replace the following line with Factory_Girl syntax
#   Todo.create(description: 'Buy some eggs', owner_email: 'not_me@example.com')
    create(:todo, description: 'Buy some eggs', owner_email: 'not_me@example.com')
    sign_in_as "me@example.com" 

    create_todo_with_description 'Buy some milk'
    user_sees_todo_item 'Buy some milk'
    user_does_not_see_todo_item 'Buy some eggs'
  end

  def create_todo_with_description(description)
    click_link 'Add a new todo'
    fill_in 'Description', with: description
    click_button 'Create todo'
  end

  def user_sees_todo_item(description)
    expect(page).to have_css 'li.todo', text: description
  end

  def user_does_not_see_todo_item(description)
    expect(page).not_to have_css 'li.todo', text: description
  end
end
