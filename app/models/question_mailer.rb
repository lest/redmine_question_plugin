class QuestionMailer < Mailer
  unloadable
  
  def asked_question(journal)
    question = journal.question
    subject "[Question ##{question.issue.id}] #{question.issue.subject}"
    recipients question.assigned_to.mail unless question.assigned_to.nil?

    body({
      :question => question,
      :issue => question.issue,
      :journal => journal,
      :issue_url => url_for(:controller => 'issues', :action => 'show', :id => question.issue)
    })

    RAILS_DEFAULT_LOGGER.debug 'Sending QuestionMailer#asked_question'
    render_multipart('asked_question', body)
  end
  
  def answered_question(question, closing_journal)
    subject "[Answered] #{question.issue.subject} ##{question.issue.id}"
    recipients question.author.mail unless question.author.nil?

    body({
      :question => question,
      :issue => question.issue,
      :journal => closing_journal,
      :issue_url => url_for(:controller => 'issues', :action => 'show', :id => question.issue)
    })

    RAILS_DEFAULT_LOGGER.debug 'Sending QuestionMailer#answered_question'
    render_multipart('answered_question', body)
  end
  
end
