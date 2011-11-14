class AssessmentsController < ApplicationController
  #layout 'assessments'

  before_filter :ensure_login

  def index
    @assessments = Assessment.all
  end

  def show
    @assessment = Assessment.find_by_slug(params[:id])
  end

  def update_response
    if @current_user.responses.length > 0
      updated = false

      @current_user.responses.each do |response|
        if response.answer.question.id == params[:question_id]
          if response.answer.id != params[:answer_id]
            Response.destroy(response)

            updated_response = Response.new

            updated_response.user_id = @current_user.id

            updated_response.answer_id = params[:answer_id]

            updated_response.save

            updated = true

            break
          end
        end
      end

      if !updated
        updated_response = Response.new

        updated_response.user_id = @current_user.id

        updated_response.answer_id = params[:answer_id]

        updated_response.save
      end
    else
      updated_response = Response.new

      updated_response.user_id = @current_user.id

      updated_response.answer_id = params[:answer_id]

      updated_response.save
    end
  end
end