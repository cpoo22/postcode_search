# frozen_string_literal: true

class SearchController < ApplicationController
  # GET /search
  def new; end

  # POST /search
  def search
    @errors = []
    begin
      @postcode = search_params

      @postcode_allowed = rules.allow?(@postcode)
    rescue ActionController::ParameterMissing
      @errors << 'You must supply a postcode'
    rescue StandardError => e
      @errors << e.message
    end

    respond_to do |format|
      format.html { render :new }
    end
  end

  private

  def search_params
    params.require(:postcode)
  end

  def rules
    PostcodeRules.new
  end
end
