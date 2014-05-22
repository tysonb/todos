class User
  attr_reader :email

  def initialize(email)
    @email = email
  end

  def todos
    Todo.all
  end
end
