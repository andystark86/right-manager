require_dependency "right_manager/application_controller"

module RightManager
  class RightsController < ApplicationController
    before_action :set_right, only: [:show, :edit, :update, :destroy]

    # GET /rights
    def index
      @rights = RightManager::Right.sorted.all
    end

    # GET /rights/1
    def show
    end

    # GET /rights/new
    def new
      @right = RightManager::Right.new
    end

    # GET /rights/1/edit
    def edit
    end

    # POST /rights
    def create
      @right = RightManager::Right.new(right_params)

      if @right.save
        redirect_to edit_right_url(@right), notice: I18n.t('flash.created', model: RightManager::Right.model_name.human)
      else
        render :new
      end
    end

    # PATCH/PUT /rights/1
    def update
      if @right.update(right_params)
        redirect_to edit_right_url(@right), notice: I18n.t('flash.updated', model: RightManager::Right.model_name.human)
      else
        render :edit
      end
    end

    # DELETE /rights/1
    def destroy
      @right.destroy
      redirect_to rights_url, notice: I18n.t('flash.destroyed', model: RightManager::Right.model_name.human)
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_right
        @right = RightManager::Right.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def right_params
        params.require(:right).permit(:description, :group_id)
      end
  end
end
