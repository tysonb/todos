require 'spec_helper'

#7:14
describe User, '#todos' do
  it 'returns all todos' do
    Todo.create(description: 'Buy some eggs')
    user = User.new('person@example.com')
    expect(user.todos.length).to eq 1
    expect(user.todos.first.description).to eq 'Buy some eggs' 
  end
end

describe User, '#todos' do
  it 'returns the email the user was instantiated with' do
    user = User.new('person@example.com')
    expect(user.email).to eq 'person@example.com'
  end
end
