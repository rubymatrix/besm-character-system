class CharacterSheetsController < ApplicationController
  before_action :set_character_sheet, only: [ :show, :edit, :update, :destroy ]
  def index
    @q    = params[:q].to_s.strip
    @sort = params[:sort].presence_in(%w[name player points updated]) || "updated"
    @dir  = params[:dir].presence_in(%w[asc desc]) || "desc"
    @view = params[:view].presence_in(%w[grid table]) || "grid" # default to grid

    scope = CharacterSheet.all
    scope = scope.where("character_name ILIKE :q OR player_name ILIKE :q", q: "%#{@q}%") if @q.present?

    order_clause = case @sort
    when "name"   then "character_name"
    when "player" then "player_name"
    when "points" then "character_points"
    else               "updated_at"
    end

    @character_sheets = scope.order(Arel.sql("#{order_clause} #{@dir}"))
  end

  def show
  end
  def new
    @character_sheet = CharacterSheet.new
  end
  def edit; end

  def create
    @character_sheet = CharacterSheet.new(character_sheet_params)

    if @character_sheet.save
      redirect_to @character_sheet, notice: "Character sheet was successfully created."
    else
      flash.now[:alert] = "There were errors creating the character sheet."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @character_sheet.update(character_sheet_params)
      redirect_to @character_sheet, notice: "Character sheet was successfully updated."
    else
      flash.now[:alert] = "There were errors updating the character sheet."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @character_sheet.destroy
    redirect_to character_sheets_path, notice: "Character sheet was successfully deleted."
  end


  def append_note
    @character_sheet = CharacterSheet.find(params[:id])
    new_note = params[:note]

    if new_note.present?
      timestamp = Time.current.strftime("%b %d, %Y %H:%M")
      prefix = @character_sheet.game_notes.present? ? "\n\n" : ""
      formatted_note = "#{prefix}[#{timestamp}]\n#{new_note}"
      @character_sheet.update!(game_notes: "#{@character_sheet.game_notes}#{formatted_note}")

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @character_sheet, notice: "Note added successfully." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_note_form_error", partial: "shared/error_message", locals: { message: "Note cannot be empty." }) }
        format.html { redirect_to @character_sheet, alert: "Note cannot be empty." }
      end
    end
  end

  def update_notes
    @character_sheet = CharacterSheet.find(params[:id])

    if @character_sheet.update(game_notes: params[:game_notes])
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @character_sheet, notice: "Notes updated successfully." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("edit_notes_form_error", partial: "shared/errors", locals: { object: @character_sheet }) }
        format.html { redirect_to @character_sheet, alert: "Failed to update notes." }
      end
    end
  end

  private

  def set_character_sheet
    @character_sheet = CharacterSheet.find(params[:id])
  end

  def character_sheet_params
    params.require(:character_sheet).permit(
      :character_name, :player_name, :gm_name, :character_points, :money,
      :race, :occupation, :habitat, :size_height_weight_gender,
      :body, :mind, :soul, :melee_acv, :ranged_acv, :melee_dcv, :ranged_dcv,
      :health_points, :energy_points, :damage_multiplier,
      :game_notes,
      character_attributes_attributes: [ :id, :name, :level, :points, :notes, :draft, :_destroy ],
      character_defects_attributes:    [ :id, :name, :rank, :bp, :notes, :_destroy ],
      equipment_entries_attributes:    [ :id, :kind, :name, :summary, :points, :notes, :draft, :_destroy ]
    )
  end
end
