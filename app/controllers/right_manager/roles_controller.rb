require_dependency "right_manager/application_controller"

module RightManager
  class RolesController < ApplicationController
    before_action :set_role, only: [:show, :edit, :update, :destroy, :update_single_right]

    # GET /roles
    def index
      @roles = RightManager::Role.sorted.all
    end

    # GET /roles/1
    def show
    end

    # GET /roles/new
    def new
      @role = RightManager::Role.new
      if params[:original_id]
        original_role = RightManager::Role.find(params[:original_id])
        @role.name = "(Copy) " + original_role.name
        @role.description = "(Copy) " + original_role.description
        original_role.roles_rights.each do |roles_right|
          @role.roles_rights.build(right_id: roles_right.right_id, access_level: roles_right.access_level)
        end
      end
    end

    # GET /roles/1/edit
    def edit
    end

    # POST /roles
    def create
      @role = RightManager::Role.new(role_params.except(:roles_rights_attributes))

      if @role.save
        #validation of RolesRight-Records fails cause the parent Role-Record doesn't exists on creation
        if @role.update(role_params)
          redirect_to edit_role_url(@role), notice: I18n.t('flash.created', model: RightManager::Role.model_name.human)
        else
          render :edit
        end
      else
        @role.assign_attributes(role_params) #reassign all params, otherwise all :roles_rights_attributes get lost
        render :new
      end
    end

    # PATCH/PUT /roles/1
    def update
      if @role.update(role_params)
        redirect_to edit_role_url(@role), notice: I18n.t('flash.updated', model: RightManager::Role.model_name.human)
      else
        render :edit
      end
    end

    # DELETE /roles/1
    def destroy
      @role.destroy
      redirect_to roles_url, notice: I18n.t('flash.destroyed', model: RightManager::Role.model_name.human)
    end

    # GET /roles/matrix
    def matrix
      @roles = RightManager::Role.includes(:rights).sorted.all
      @rights = RightManager::Right.sorted_by_group.all
    end

    # PATCH /roles/:id
    def update_single_right
      roles_right = @role.roles_rights.where(right_id: params[:right_id]).first

      #use update with nested attributes to invoke the :reject_if model validation
      if @role.update(
          roles_rights_attributes: [
              {
                  id: roles_right.try(:id),
                  access_level: params[:access_level],
                  right_id: params[:right_id]
              }
          ])
        respond_to do |format|
          format.js { head :ok}
        end
      else
        respond_to do |format|
          format.js { render plain: @role.errors.to_a.join(', ')}
        end
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_role
        @role = RightManager::Role.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def role_params
        params.require(:role).permit(:name, :description, roles_rights_attributes: [ :id, :access_level, :right_id])
      end
  end
end
