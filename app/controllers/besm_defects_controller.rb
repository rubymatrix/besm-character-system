class BesmDefectsController < ApplicationController
  layout "dashboard"
  before_action :set_besm_defect, only: %i[ edit update ]

  def edit
  end

  def update
    if @besm_defect.update(besm_defect_params)
      redirect_to defects_besm_references_path, notice: "Defect was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_besm_defect
      @besm_defect = BesmDefect.find(params[:id])
    end

    def besm_defect_params
      params.require(:besm_defect).permit(:name, :defect_type, :cost_per_level, :description)
    end
end
