# frozen_string_literal: true

# Fetches articles from the NYT API and extracts sentences out of them
class NYT
  attr_accessor :articles

  def initialize
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
    print ENV['NYT_API_KEY']
    articles = Faraday.get(popular_articles_endpoint, { 'api-key': ENV['NYT_API_KEY'] })
    articles.body
  end
end
