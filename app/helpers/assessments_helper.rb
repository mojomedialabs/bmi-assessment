module AssessmentsHelper
  def check_answer(answer_id)
    response = @current_user.responses.detect { |response| response.answer_id == answer_id }

    return !response.nil?
  end

  def get_results(assessment)
    assessment_results = "<div class=\"assessment-result\">"

    assessment_score = assessment.score(@current_user)

    assessment_results += "<h2>#{assessment_score}</h2>"

    assessment.results.each do |result|
      if assessment_score >= result.bottom and assessment_score <= result.top
        assessment_results += result.content

        break
      end
    end

    assessment_results += "</div>"

    assessment_results += "<div class=\"section-results-list\"><ul>"

    assessment.sections.each do |section|
      assessment_results += "<li><a href=\"#section#{section.id}\">#{section.title}</a></li>"
    end

    assessment_results += "</ul></div>"

    assessment.sections.each do |section|
      section_results = "<div class=\"section-result\"><a name=\"section#{section.id}\"></a>"

      section_score = section.score(@current_user)

      section_results += "<h2>#{section.title}</h2>"
      section_results += "<h3>Your Score: #{section_score}</h3>"

      section.results.each do |result|
        if section_score >= result.bottom and section_score <= result.top
          section_results += result.content

          break
        end
      end

      section_results += "</div>"

      assessment_results += section_results
    end

    assessment_results
  end
end
