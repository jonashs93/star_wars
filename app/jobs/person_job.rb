class PersonJob < ApplicationJob
  queue_as :default

  def perform(data)
    PersonService.new(data).import
  end
end
