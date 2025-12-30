class AttributeLimitersController < ApplicationController
  layout "dashboard"
  before_action :set_limiter, only: %i[ edit update ]

  def edit
  end

  def update
    if @limiter.update(limiter_params)
      redirect_to limiters_besm_references_path, notice: "Limiter was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_limiter
      @limiter = AttributeLimiter.find(params[:id])
    end

    def limiter_params
      params.require(:attribute_limiter).permit(:name, :cost_per_level, :description)
    end
end
