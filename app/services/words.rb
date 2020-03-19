# frozen_string_literal: true

# Interfaces with the Words API
class Words
  def initialize
    @words_api_key = Rails.application.credentials.words[:key]
    @words_url = 'https://wordsapiv1.p.rapidapi.com/words/'
  end

  def word(incoming_word)
    get_word(incoming_word)
  end

  def random_word
    get_word('', { random: true })
  end

  private

  def get_word(path = '', queries = {}, headers = {})
    headers['x-rapidapi-key'] = @words_api_key
    response = Faraday.get([@words_url, path].join(''), queries, headers)
    JSON.parse(response.body, symbolize_names: true)
  end
end
