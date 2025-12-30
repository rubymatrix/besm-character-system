class BesmReferencesController < ApplicationController
  layout "dashboard"
  def index
    @attributes_count = BesmAttribute.count
    @defects_count = BesmDefect.count
    @enhancements_count = AttributeEnhancement.count
    @limiters_count = AttributeLimiter.count
    @weapon_enhancements_count = WeaponEnhancement.count
    @weapon_limiters_count = WeaponLimiter.count
  end

  def attributes
    @attributes = BesmAttribute.order(:name)
  end

  def defects
    @defects = BesmDefect.order(:name)
  end

  def enhancements
    @enhancements = AttributeEnhancement.order(:name)
  end

  def limiters
    @limiters = AttributeLimiter.order(:name)
  end

  def weapon_enhancements
    @weapon_enhancements = WeaponEnhancement.order(:name)
  end

  def weapon_limiters
    @weapon_limiters = WeaponLimiter.order(:name)
  end
  def search
    @query = params[:q]

    if @query.present?
      search_term = "%#{@query}%"
      @attributes = BesmAttribute.where("name LIKE ?", search_term)
      @defects = BesmDefect.where("name LIKE ?", search_term)
      @enhancements = AttributeEnhancement.where("name LIKE ?", search_term)
      @limiters = AttributeLimiter.where("name LIKE ?", search_term)
      @weapon_enhancements = WeaponEnhancement.where("name LIKE ?", search_term)
      @weapon_limiters = WeaponLimiter.where("name LIKE ?", search_term)
    else
      @attributes = []
      @defects = []
      @enhancements = []
      @limiters = []
      @weapon_enhancements = []
      @weapon_limiters = []
    end
  end
end
