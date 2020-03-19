# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sentences = NYT.new.sentences

sentences.each do |sentence|
  begin
    sent = Sentence.create(original: sentence)
    Question.create(sentence: sent)
  rescue => exception
    p 'Failed to create question for:'
    p sent
    p exception
  end
end
