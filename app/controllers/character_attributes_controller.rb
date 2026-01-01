class CharacterAttributesController < ApplicationController
  before_action :set_character_sheet

  def create
    @character_attribute = @character_sheet.character_attributes.build(character_attribute_params)

    if @character_attribute.save
      redirect_to @character_sheet, notice: "Attribute was successfully added."
    else
      redirect_to @character_sheet, alert: "Failed to add attribute: #{@character_attribute.errors.full_messages.join(", ")}"
    end
  end

  def update
    @character_attribute = @character_sheet.character_attributes.find(params[:id])

    if @character_attribute.update(character_attribute_params)
      redirect_to @character_sheet, notice: "Attribute was successfully updated."
    else
      redirect_to @character_sheet, alert: "Failed to update attribute: #{@character_attribute.errors.full_messages.join(", ")}"
    end
  end

  def publish
    @character_attribute = @character_sheet.character_attributes.find(params[:id])

    if @character_attribute.update(draft: false)
      redirect_to @character_sheet, notice: "Attribute was published."
    else
      redirect_to @character_sheet, alert: "Failed to publish attribute."
    end
  end

  def destroy
    @character_attribute = @character_sheet.character_attributes.find(params[:id])
    @character_attribute.destroy
    redirect_to @character_sheet, notice: "Attribute was deleted."
  end

  private

  def set_character_sheet
    @character_sheet = CharacterSheet.find(params[:character_sheet_id])
  end

  def character_attribute_params
    params.require(:character_attribute).permit(:name, :level, :points, :notes, :draft)
  end
end
