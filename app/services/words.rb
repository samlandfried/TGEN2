# frozen_string_literal: true

# Interfaces with the Words API
class Words
  def initialize
    @words_api_key = Rails.application.credentials.words[:key]
    @base_url = 'https://wordsapiv1.p.rapidapi.com'
  end

  def word(word)
    url = [@base_url, 'words', word].join('/')
    response = Faraday.get(url, {}, { 'x-rapidapi-key': @words_api_key })
    word_info = JSON.parse(response.body, symbolize_names: true)
  end
end
