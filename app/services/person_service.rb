# classe responsavel por persistir e vincular personagem e seus relacionamentos
class PersonService

  attr_accessor :person, :attributes

  def initialize(attributes)
    self.attributes = attributes
    self.person = Person.new(name: self.attributes['name'],
                             mass: self.attributes['mass'],
                             birth_year: self.attributes['birth_year'])
  end

  def import
    ActiveRecord::Base.transaction do
      # cria pergonagem
      self.person.save!
      import_dependents
    end
  end

  private

  # verifica se possui relacionamentos
  def import_dependents
    import_dependent('homeworld')
    import_dependent('species')
    import_dependent('starships')
  end

  # importa relacionamento
  def import_dependent(dependent_name)
    dependent_urls = handle_url_dependent(dependent_name)

    dependent_urls.each do |url|
      dependent_attributes = HTTParty.get(url)
      # busca ou cria registro
      dependent_object = klass_dependent(dependent_name).first_or_create!(name: dependent_attributes['name'])
      add_dependent(dependent_object, dependent_name)
    end
  end

  # define classe utilizando como referencia o nome do relacionamento
  def klass_dependent(dependent)
    dependent.to_s.classify.constantize
  end

  # seleciona e normaliza urls de relacionamento para sempre ser um array
  def handle_url_dependent(dependent)
    [self.attributes[dependent]].flatten
  end

  # vincula registro ao personagem, has_many ou belongs_to
  def add_dependent(dependent_object, dependent_name)
    association = self.person.class.reflect_on_association(dependent_name)
    if association.belongs_to?
      self.person.update_attribute("#{dependent_name}_id", dependent_object)
    else
      PersonDependent.create!(person: self.person, dependent: dependent_object)
    end
  end
end
