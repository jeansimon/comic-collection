class UsersController < ApplicationController

	before_action :set_user

	def show
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to @user, notice: "Your information has been successfully updated!"
		else
			render :edit
		end
	end

	def destroy
		@user.destroy

		redirect_to root_path, alert: "Your account has been successfully deleted."
	end

private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

end