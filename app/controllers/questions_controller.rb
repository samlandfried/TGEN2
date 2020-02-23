# frozen_string_literal: true

class QuestionsController < ApplicationController
  def create
    @sentence = Sentence.find_or_create_by original: question_params['sentence']
    @question = Question.new(sentence: @sentence)

    if @question.save
      render json: @question, status: :created
    else
      head :bad_request
    end
  end

  private

  def question_params
    params.require(:question).permit(:sentence)
  end
end
