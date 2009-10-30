class ClickatellChannelHandler < ChannelHandler
  def handle(msg)
    Delayed::Job.enqueue SendClickatellMessageJob.new(@channel.id, msg.id)
  end
end

class SendClickatellMessageJob < Struct.new(:channel_id, :message_id)
  def perform
    channel = Channel.find self.channel_id
    msg = AOMessage.find self.message_id
    
    uri = "http://api.clickatell.com/http/sendmsg"
    uri += "?api_id=" + channel.configuration[:api_id]
    uri += '&user=' + channel.configuration[:user]
    uri += '&password=' + channel.configuration[:password]
    uri += '&from=' + msg.from
    uri += '&to=' + msg.to
    uri += '&text=' + msg.body
    
    response = Net::HTTP.request_get(uri)
    response.body[4 ... response.body.length]
  end
end