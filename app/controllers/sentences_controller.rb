# frozen_string_literal: true

class SentencesController < ApplicationController
  def index
    respond_to do |format|
      sentences = NYT.new.sentences
      format.json { render json: sentences }
    end
  end

  def create
    @sentence = Sentence.new(sentence_params)

    if @sentence.save
      render json: @sentence, status: :created
    else
      head :bad_request
    end
  end

  private

  def sentence_params
    params.require(:sentence).permit(:original)
  end
end
