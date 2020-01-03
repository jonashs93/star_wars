class PeopleController < ApplicationController

  def index
  end

  def collection
    per_page = 10
    results = Person.order(:name).page(params[:page]).per(per_page)
    response = {
      'total': results.total_count,
      'per_page': per_page,
      'current_page': params[:page],
      'last_page': (results.total_count / per_page) + 1,
      'prev_page_url': prev_page_url,
      'next_page_url': next_page_url,
      'from': (params[:page].to_i * per_page) - 9,
      'to': params[:page].to_i * per_page,
      'data': results
    }
    render json: response
  end

  def show
    person = Person.find params[:id]
    render json: { greeting: greeting_message(person) }
  end

  private

  def greeting_message(person, language="pt-br")
    I18n.t("hello")
    # "Olá! Meu nome é #{person.name}. Sou um #{person.species.first&.name}, peso #{person.mass} kg, " \
    # "nasci em #{person.homeworld&.name} no ano #{person.birth_year} e #{starships(person)}."
  end

  def starships(person)
    if person.starships.any?
      "já pilotei #{person.starships.map(&:name).to_sentence}"
    else
      "nunca pilotei"
    end
  end

  def next_page_url
    "#{url}?page=#{params[:page].to_i + 1}"
  end

  def prev_page_url
    "#{url}?page=#{params[:page].to_i - 1}"
  end

  def url
    'http://127.0.0.1:3000/people/api'
  end
end
