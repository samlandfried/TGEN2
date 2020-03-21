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

  def random_word(word = nil)
    word ? get_word_similar_to(word) : get_word('', { random: true })
  end

  private

  def get_word(path = '', queries = {}, headers = {})
    headers['x-rapidapi-key'] = @words_api_key
    response = Faraday.get([@words_url, path].join(''), queries, headers)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_word_similar_to(incoming_word)
    word_details = get_word(incoming_word)

    queries = {
      lettersMin: incoming_word.length < 6 ? 3 : incoming_word.length - 3,
      lettersMax: incoming_word.length + 3,
      frequencymin: word_details[:frequency] - 0.5,
      frequencyMax: word_details[:frequency] + 0.5,
      partOfSpeech: word_details[:results].first[:partOfSpeech],
      random: true
    }

    get_word('', queries)
  end
end
