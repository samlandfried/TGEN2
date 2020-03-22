# frozen_string_literal: true

class CheckAnswerController < ApplicationController
  def create
    question = Question.find(question_id)
    check_answer_code = question.check_answer(answer_param)

    case check_answer_code
    when 'CORRECT'
      render json: { code: check_answer_code, message: "Option '#{answer_param}' completes the sentence." }, status: :ok
    when 'INCORRECT'
      render json: { code: check_answer_code, message: "Option '#{answer_param}' does not complete the sentence."}, status: :ok
    when 'NOT_FOUND'
      render json: { code: check_answer_code, message: "Option '#{answer_param} is not associated with the question"}, status: :not_found
    else
      render nothing: true, status: :system_error
    end
  end

  private

  def check_answer_params
    params.require(:check_answer)
  end

  def answer_param
    check_answer_params.require(:word)
  end

  def question_id
    params.require(:question_id)
  end
end
