class SessionController < ApplicationController
  def new
  end

  def create
    # cherche s'il existe un utilisateur en base avec l’e-mail
    user = User.find_by(email: params[:connect_email])

    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe
    if user && user.authenticate(params[:connect_password])
      session[:user_id] = user.id
      # redirige où tu veux, avec un flash ou pas
      redirect_to welcome_path(:id => User.find_by(id: session[:user_id]).first_name)

    else
      flash.now[:danger] = 'Combinaison Email/Code secret incorrecte. Réessayez'
      render 'new'
    end
  end

  def destroy
     session.delete(:user_id)
     redirect_to gossips_path
  end

end
