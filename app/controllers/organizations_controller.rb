class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.sorted
  end

  def show
    @organization = Organization.find(params[:id])
    # @event = Event.find(params[:event_id])
  end  

  def new
    @organization = Organization.new
  end
  
  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      flash[:notice] = "Organization created successfully."
      redirect_to(organizations_path)
    else
      render('new')
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    if @organization.update_attributes(organization_params)
      flash[:notice] = "Organization updated successfully."
      redirect_to(organizations_path)
    else
      render('edit')
    end
  end

  def delete
    @organization = Organization.find(params[:id])
  end  

  def destroy
    @organization.destroy
    flash[:notice] = "Organization '#{@organization.name}' destroyed successfully."
    redirect_to(organizations_path)
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :address, :description)
  end

end
