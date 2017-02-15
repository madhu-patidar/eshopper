class MessageReply < ApplicationMailer

   def message_reply(contect)
    @contect = contect
    @message_reply = contect.admin_reply
    @url  = 'http://madhu-eshopper.herokuapp.com/customers/sign_in'
    attachments.inline["logo.png"] = File.read("app/assets/images/home/logo.png")
    mail(to: @contect.email, subject: 'Reply')
  end
  
end
