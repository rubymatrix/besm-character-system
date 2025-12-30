class BesmAttributesController < ApplicationController
  layout "dashboard"
  before_action :set_besm_attribute, only: %i[ edit update ]

  def edit
  end

  def update
    if @besm_attribute.update(besm_attribute_params)
      redirect_to attributes_besm_references_path, notice: "Attribute was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_besm_attribute
      @besm_attribute = BesmAttribute.find(params[:id])
    end

    def besm_attribute_params
      params.require(:besm_attribute).permit(:name, :attribute_cost, :cost_per_level, :relevant_stat, :description)
    end
end
