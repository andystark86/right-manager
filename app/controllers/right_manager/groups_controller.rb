require_dependency "right_manager/application_controller"

module RightManager
  class GroupsController < ApplicationController

    before_action :set_group, only: [:show, :edit, :update, :destroy]

    # GET /groups
    def index
      @groups = RightManager::Group.sorted.all
    end

    # GET /groups/1
    def show
    end

    # GET /groups/new
    def new
      @group = RightManager::Group.new
    end

    # GET /groups/1/edit
    def edit
    end

    # POST /groups
    def create
      @group = RightManager::Group.new(group_params)

      if @group.save
        redirect_to edit_group_url(@group), notice: I18n.t('flash.created', model: RightManager::Group.model_name.human)
      else
        render :new
      end
    end

    # PATCH/PUT /groups/1
    def update
      if @group.update(group_params)
        redirect_to edit_group_url(@group), notice: I18n.t('flash.updated', model: RightManager::Group.model_name.human)
      else
        render :edit
      end
    end

    # DELETE /groups/1
    def destroy
      @group.destroy
      redirect_to groups_url, notice: I18n.t('flash.destroyed', model: RightManager::Group.model_name.human)
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = RightManager::Group.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_params
      params.require(:group).permit(:name)
    end
  end
  
end
