# frozen_string_literal: true

class SearchController < ApplicationController
  # GET /search
  def new; end

  # POST /search
  def search
    @postcode = search_params

    @postcode_allowed = rules.allow?(@postcode)

    respond_to do |format|
      format.html { render :new }
    end
  end

  private

  def search_params
    params.require(:postcode)
  end

  def rules
    @rules ||= PostcodeRules.new
  end
end
