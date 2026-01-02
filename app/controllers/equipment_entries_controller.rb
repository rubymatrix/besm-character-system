class EquipmentEntriesController < ApplicationController
  before_action :set_character_sheet

  def create
    @equipment_entry = @character_sheet.equipment_entries.build(equipment_entry_params)

    if @equipment_entry.save
      redirect_to @character_sheet, notice: "Equipment was successfully added."
    else
      redirect_to @character_sheet, alert: "Failed to add equipment: #{@equipment_entry.errors.full_messages.join(", ")}"
    end
  end

  def destroy
    @equipment_entry = @character_sheet.equipment_entries.find(params[:id])
    @equipment_entry.destroy
    redirect_to @character_sheet, notice: "Equipment was removed."
  end

  def update
    @equipment_entry = @character_sheet.equipment_entries.find(params[:id])

    if @equipment_entry.update(equipment_entry_params)
      redirect_to @character_sheet, notice: "Equipment was successfully updated."
    else
      redirect_to @character_sheet, alert: "Failed to update equipment: #{@equipment_entry.errors.full_messages.join(", ")}"
    end
  end

  def publish
    @equipment_entry = @character_sheet.equipment_entries.find(params[:id])

    if @equipment_entry.update(draft: false)
      redirect_to @character_sheet, notice: "Equipment was published."
    else
      redirect_to @character_sheet, alert: "Failed to publish equipment."
    end
  end

  private

  def set_character_sheet
    @character_sheet = CharacterSheet.find(params[:character_sheet_id])
  end

  def equipment_entry_params
    params.require(:equipment_entry).permit(
      :kind,
      :name,
      :summary,
      :points,
      :notes,
      :draft,
      adjusters_attributes: [:id, :stat, :amount, :condition, :_destroy]
    )
  end
end
