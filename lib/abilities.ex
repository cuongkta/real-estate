alias RealEstate.Account.User
alias RealEstate.Condos.Project
#require IEx
defimpl Canada.Can, for: User do

  def can?(%User{ id: user_id }, action, %Project{ user_id: user_id })
    when action in [:update, :delete], do: true

  

  # def can?(%User{} = user, action, %Project{user_id: user_id})  when action in [:show] do
  #   user.email == "owner"
  # end


  # def can?(user, action, Rental) when action in [:new, :create] do
  # 	user.role == "owner"
  # end
  # def can?(user, action, rental = %Rental{}) do
  #   rental.owner_id == user.id
  # end
  def can?(%User{ id: _ }, _, _), do: true
  def can?(nil, :show, %Project{}), do: true
  #def can?(nil, _, _), do: false
end