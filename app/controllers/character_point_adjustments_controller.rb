class CharacterPointAdjustmentsController < ApplicationController
  before_action :set_character_sheet

  def create
    @adjustment = @character_sheet.character_point_adjustments.build(adjustment_params)

    if @adjustment.save
      redirect_to @character_sheet, notice: "Character points adjusted successfully."
    else
      redirect_to @character_sheet, alert: "Failed to adjust character points."
    end
  end

  def destroy
    @adjustment = @character_sheet.character_point_adjustments.find(params[:id])
    @adjustment.destroy
    redirect_to @character_sheet, notice: "Adjustment removed."
  end

  private

  def set_character_sheet
    @character_sheet = CharacterSheet.find(params[:character_sheet_id])
  end

  def adjustment_params
    params.require(:character_point_adjustment).permit(:points, :reason)
  end
end
