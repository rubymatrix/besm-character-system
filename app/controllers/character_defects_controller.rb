# app/controllers/character_defects_controller.rb
class CharacterDefectsController < ApplicationController
  before_action :set_character_sheet
  before_action :set_defect, only: [:update, :destroy]

  def create
    @defect = @character_sheet.character_defects.build(defect_params)
    
    if @defect.save
      redirect_to @character_sheet, notice: "Defect was successfully added."
    else
      redirect_to @character_sheet, alert: "Failed to add defect: #{@defect.errors.full_messages.join(', ')}"
    end
  end

  def update
    if @defect.update(defect_params)
      redirect_to @character_sheet, notice: "Defect was successfully updated."
    else
      redirect_to @character_sheet, alert: "Failed to update defect: #{@defect.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    @defect.destroy
    redirect_to @character_sheet, notice: "Defect was successfully deleted."
  end

  private

  def set_character_sheet
    @character_sheet = CharacterSheet.find(params[:character_sheet_id])
  end

  def set_defect
    @defect = @character_sheet.character_defects.find(params[:id])
  end

  def defect_params
    params.require(:character_defect).permit(:name, :rank, :bp, :notes)
  end
end
