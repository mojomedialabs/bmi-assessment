module AssessmentsHelper
  def get_status(assessment)
    if assessment.complete?(@current_user)
      return ("Completed! " + link_to("View Results", results_assessment_path(assessment))).html_safe
    elsif assessment.started?(@current_user)
      return "Started".html_safe
    else
      return "Not Started".html_safe
    end
  end

  def check_answer(answer_id)
    response = @current_user.responses.detect { |response| response.answer_id == answer_id }

    return !response.nil?
  end

  def get_result(assessment)
    assessment_result = ""

    assessment_score = assessment.score(@current_user)

    assessment.results.each do |result|
      if assessment_score >= result.bottom and assessment_score <= result.top
        assessment_result += result.content.gsub(/\[Company Name\]/, @current_user.company_name).gsub(/\[Company Nickname\]/, @current_user.company_name)

        break
      end
    end

    return assessment_result.html_safe
  end

  def get_results(assessment)
    assessment_results = "<div class=\"assessment-result\">"

    assessment_score = assessment.score(@current_user)

    assessment_results += "<h2>#{assessment_score}</h2>"

    assessment.results.each do |result|
      if assessment_score >= result.bottom and assessment_score <= result.top
        assessment_results += result.content.gsub(/\[Company Name\]/, @current_user.company_name).gsub(/\[Company Nickname\]/, @current_user.company_name)

        break
      end
    end

    assessment_results += "</div>"

    assessment_results += "<div class=\"section-results-list\"><ul>"

    assessment.sections.each do |section|
      assessment_results += "<li>#{section.title}</li>"
    end

    assessment_results += "</ul></div>"

    assessment.sections.each do |section|
      section_results = "<div class=\"section-result\">"

      section_score = section.score(@current_user)

      section_results += "<h2>#{section.title}</h2>"
      section_results += "<h3>Your Score: #{section_score}</h3>"

      section.results.each do |result|
        if section_score >= result.bottom and section_score <= result.top
          section_results += result.content.gsub(/\[Company Name\]/, @current_user.company_name).gsub(/\[Company Nickname\]/, @current_user.company_name)

          break
        end
      end

      section_results += "</div>"

      assessment_results += section_results
    end

    assessment_results.html_safe
  end
end
