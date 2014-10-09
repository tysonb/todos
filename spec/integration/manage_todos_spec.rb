# 4 phases of a test
# 1) setup
# 2) exercise/execute
# 3) verify
# 4) teardown (deleting a file from the filesystem if you've created it during the scenario, or clearing out db)

require 'spec_helper'

feature 'Manage todos' do
  scenario 'create a new todo' do
    # setup
    sign_in

    # execute
    create_todo_with_description 'Buy some milk'
    # verify
    user_sees_todo_item 'Buy some milk'
  end

  scenario 'view only my todos' do
    # setup
    create(:todo, description: 'Buy some eggs', owner_email: 'not_me@example.com')
    sign_in_as "me@example.com" 

    # execute
    create_todo_with_description 'Buy some milk'

    # verify
    user_sees_todo_item 'Buy some milk'
    user_does_not_see_todo_item 'Buy some eggs'
  end

  scenario 'mark todos as complete' do
    # setup
    sign_in
    create_todo_with_description 'Buy some milk'

    # execute
    complete_todo 'Buy some milk'
    # verify
    user_sees_completed_todo_item 'Buy some milk'
  end

  def complete_todo(description)
    within "li.todo:contains('#{description}')" do
      click_link 'Complete'
    end
  end

  def create_todo_with_description(description)
    click_link 'Add a new todo'
    fill_in 'Description', with: description
    click_button 'Create todo'
  end

  def user_sees_completed_todo_item(description)
    expect(page).to have_css 'li.todo.completed', text: description
  end

  def user_sees_todo_item(description)
    expect(page).to have_css 'li.todo', text: description
  end

  def user_does_not_see_todo_item(description)
    expect(page).not_to have_css 'li.todo', text: description
  end
end
