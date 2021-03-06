module Commontator
  class SubscriptionsMailer < ActionMailer::Base
    def comment_created(comment, recipients)
      setup_variables(comment, recipients)

      @to.each do |email|
        mail :to => email,
            :from => @from,
            :subject => "HearthStats | New Comment on #{@commontable_name}"
      end
    end

    protected

    def setup_variables(comment, recipients)
      @comment = comment
      @thread = @comment.thread
      @creator = @comment.creator

      @creator_name = Commontator.commontator_name(@creator)

      @commontable_name = Commontator.commontable_name(@thread)

      @commontable_url = Commontator.commontable_url(@thread, main_app)

      if @thread.commontable_type == "Deck"
        deck_name = @thread.commontable.name
        @commontable_name = deck_name
      end
      params = Hash.new
      params[:comment] = @comment
      params[:thread] = @thread
      params[:creator] = @creator
      params[:creator_name] = @creator_name
      params[:commontable_name] = @commontable_name
      params[:commontable_url] = @commontable_url

      @to = recipients.collect{|s| Commontator.commontator_email(s, self)}
      @from = @thread.config.email_from_proc.call(@thread)
    end
  end
end
