class WeaponEnhancementsController < ApplicationController
  layout "dashboard"
  before_action :set_enhancement, only: %i[ edit update ]

  def edit
  end

  def update
    if @enhancement.update(enhancement_params)
      redirect_to weapon_enhancements_besm_references_path, notice: "Weapon Enhancement was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_enhancement
      @enhancement = WeaponEnhancement.find(params[:id])
    end

    def enhancement_params
      params.require(:weapon_enhancement).permit(:name, :ranks, :cost_per_level, :description)
    end
end
