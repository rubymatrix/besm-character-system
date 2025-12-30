class AttributeEnhancementsController < ApplicationController
  layout "dashboard"
  before_action :set_enhancement, only: %i[ edit update ]

  def edit
  end

  def update
    if @enhancement.update(enhancement_params)
      redirect_to enhancements_besm_references_path, notice: "Enhancement was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_enhancement
      @enhancement = AttributeEnhancement.find(params[:id])
    end

    def enhancement_params
      params.require(:attribute_enhancement).permit(:name, :cost_per_level, :description)
    end
end
