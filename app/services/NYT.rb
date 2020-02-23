# frozen_string_literal: true

# Fetches articles from the NYT API and extracts sentences out of them
class NYT
  attr_reader :sentences

  def initialize(days = 7)
    @nyt_api_key = Rails.application.credentials.nyt[:key]
    @base_url = 'https://api.nytimes.com/'
    @popular_articles_endpoint = "#{@base_url}svc/mostpopular/v2/emailed/#{days}.json"
    @sentences = abstracts
  end

  def make_sentence
    sentences[0]
  end

  private

  def popular_articles
    response = Faraday.get(popular_articles_endpoint, { 'api-key': @nyt_api_key })
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def abstracts(articles = popular_articles)
    articles.map { |article| article[:abstract] }
  end
end
