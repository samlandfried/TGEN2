# frozen_string_literal: true

# Interfaces with the Words API
class Words
  def initialize
    @words_api_key = Rails.application.credentials.words[:key]
    @words_url = 'https://wordsapiv1.p.rapidapi.com/words/'
  end

  def word(incoming_word)
    url = [@words_url, incoming_word].join('')
    response = Faraday.get(url, {}, { 'x-rapidapi-key': @words_api_key })
    JSON.parse(response.body, symbolize_names: true)
  end

  def random_word
    response = Faraday.get(@words_url, { random: true }, { 'x-rapidapi-key': @words_api_key })
    JSON.parse(response.body, symbolize_names: true)
  end
end
