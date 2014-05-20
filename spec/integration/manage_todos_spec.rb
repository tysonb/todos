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
    click_link 'Add a new todo'
    fill_in 'Description', with: 'Buy some milk'
    click_button 'Create todo'

    expect(page).to have_css 'li.todo', text: 'Buy some milk'
  end
end
