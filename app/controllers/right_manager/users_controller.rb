require_dependency "right_manager/application_controller"

module RightManager
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]


    # GET /users
    def index
      @users = RightManager.user_class.includes(:role).all.page(params[:page]).per(20)
    end

    # GET /users/1
    def show
    end

    # GET /users/new
    def new
      @user = RightManager.user_class.new
    end

    # GET /users/1/edit
    def edit
      unless @user.role.present?
        flash[:error] = t('view.right_manager.user_has_no_role')
        redirect_to users_path
      end
    end

    # POST /users
    def create
      @user = RightManager.user_class.new(user_params)

      if @user.save
        redirect_to edit_user_url(@user), notice: I18n.t('flash.created', model: RightManager.user_class.model_name.human)
      else
        render :new
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        redirect_to edit_user_url(@user), notice: I18n.t('flash.updated', model: RightManager.user_class.model_name.human)
      else
        render :edit
      end
    end

    # DELETE /users/1
    def destroy
      @user.destroy
      redirect_to users_url, notice: I18n.t('flash.destroyed', model: RightManager.user_class.model_name.human)
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = RightManager.user_class.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(users_rights_attributes: [ :id, :access_level, :right_id])
      end
  end
end
