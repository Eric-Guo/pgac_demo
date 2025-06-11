class SideKiqBase
  include Sidekiq::Job

  protected

  def render_message(message)
    ApplicationController.renderer.render(partial: "messages/message", locals: {message: message})
  end
end
