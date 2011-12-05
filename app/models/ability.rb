class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :user
    end
  end

end
