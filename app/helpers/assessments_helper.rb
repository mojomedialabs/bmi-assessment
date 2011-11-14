module AssessmentsHelper
  def check_answer(answer_id)
    response = @current_user.responses.detect { |response| response.answer_id == answer_id }

    return !response.nil?
  end
end
