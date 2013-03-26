require 'twilio-ruby'
require 'sinatra'
require 'rack-flash'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
  erb :index
end


post '/submit' do
  @message = "#{params[:user]} thought the baba was #{params[:input]}"
  
  # Change these to match your Twilio account settings 
  @account_sid = "AC14aa346613c89fec467663aad46c05a2"
  @auth_token = "0e43d0a04e110f7faa2692e388b0c7f5"
  
  # Set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    
  @account = @client.account


  if params[:tc] == "1" and params[:user]!="First Name, Last Name" and params[:input]!="The baba is..."||nil
    @sms = @account.sms.messages.create({
      :from => '+13473217539', 
      :to => '+16462363162',
      :body => @message
    })  


    flash[:notice] = "Thank You #{params[:user]}"
    redirect '/'  
    

  else
    flash[:notice] = "Name and Certification please."
    redirect '/'
  end
end