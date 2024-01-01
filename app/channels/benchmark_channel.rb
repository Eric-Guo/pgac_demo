class BenchmarkChannel < ApplicationCable::Channel
  def subscribed
    stream_from "all#{stream_id}"
  end

  def echo(data)
    transmit data
  end

  def broadcast(data)
    ActionCable.server.broadcast "all#{stream_id}", data
    data['action'] = 'broadcastResult'
    transmit data
  end

  def counter(data)
    num = data.fetch('num', 100).to_i
    num.times { ActionCable.server.broadcast 'all', { text: "Count: #{_1}" } }
  end

  private

  def stream_id
    params[:id] || ''
  end
end
