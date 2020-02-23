# frozen_string_literal: true

class SentencesController < ApplicationController
  def index
    respond_to do |format|
      sentences = NYT.new.sentences
      format.json { render json: sentences }
    end
  end
end
