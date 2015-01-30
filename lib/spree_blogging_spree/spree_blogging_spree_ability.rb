class SpreeInspirationSpreeAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Spree::InspirationEntry
    can :index, Spree::InspirationEntry
  end
end
