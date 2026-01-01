class CharacterAttributesController < ApplicationController
  before_action :set_character_sheet

  def publish
    @character_attribute = @character_sheet.character_attributes.find(params[:id])

    if @character_attribute.update(draft: false)
      redirect_to @character_sheet, notice: "Attribute was published."
    else
      redirect_to @character_sheet, alert: "Failed to publish attribute."
    end
  end

  private

  def set_character_sheet
    @character_sheet = CharacterSheet.find(params[:character_sheet_id])
  end
end
