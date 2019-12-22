# classe utilizada para percorrer todas paginas dos personagens
# e disparar um processo para cada personagem
class ImportService

  attr_accessor :url, :data

  def initialize(url)
    self.url = url
  end

  def execute
    # percorre paginas
    while self.url
      # carrega personagens da pagina atual
      self.data = get_data

      # percorre personagens da pagina atual
      self.data['results'].each do |person_data|
        # realiza importacao em background
        send_job(person_data)
      end

      # seleciona url da proxima pagina
      self.url = get_next_url
    end
  end

  private

  def get_data
    HTTParty.get(self.url)
  end

  def get_next_url
    self.data.parsed_response['next']
  end

  def send_job(person_data)
    PersonJob.perform_later(person_data)
  end
end
