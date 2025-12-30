class MoneyAdjustmentsController < ApplicationController
  before_action :set_character_sheet

  def create
    @money_adjustment = @character_sheet.money_adjustments.build(money_adjustment_params)

    if @money_adjustment.save
      redirect_to @character_sheet, notice: "Money was successfully adjusted."
    else
      redirect_to @character_sheet, alert: "Failed to adjust money: #{@money_adjustment.errors.full_messages.join(", ")}"
    end
  end

  def destroy
    @money_adjustment = @character_sheet.money_adjustments.find(params[:id])
    @money_adjustment.destroy
    redirect_to @character_sheet, notice: "Money adjustment was removed."
  end

  private

  def set_character_sheet
    @character_sheet = CharacterSheet.find(params[:character_sheet_id])
  end

  def money_adjustment_params
    params.require(:money_adjustment).permit(:amount, :reason)
  end
end
