class WeaponLimitersController < ApplicationController
  layout "dashboard"
  before_action :set_limiter, only: %i[ edit update ]

  def edit
  end

  def update
    if @limiter.update(limiter_params)
      redirect_to weapon_limiters_besm_references_path, notice: "Weapon Limiter was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_limiter
      @limiter = WeaponLimiter.find(params[:id])
    end

    def limiter_params
      params.require(:weapon_limiter).permit(:name, :ranks, :cost_per_level, :description)
    end
end
