# frozen_string_literal: true

# Fetches articles from the NYT API and extracts sentences out of them
class NYT
  attr_accessor :articles

  def initialize
    @nyt_api_key = Rails.application.credentials.nyt[:key]
    @url = 'https://api.nytimes.com/'
  end

  def make_sentence
    print fetch_popular_articles
  end

  private

  def popular_articles_endpoint(days = 7)
    "#{@url}svc/mostpopular/v2/emailed/#{days}.json"
  end

  def fetch_popular_articles
    articles = Faraday.get(popular_articles_endpoint, { 'api-key': @nyt_api_key })
    articles.body
  end
end
