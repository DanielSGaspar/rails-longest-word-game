require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    word = params[:word]
    letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response_serialized = URI.open(url).read
    api_response = JSON.parse(response_serialized)
    english_word = api_response['found']

    @result = ''
    word_is_valid = word.chars.all? { |x| word.count(x) <= letters.count(x) }
    if word_is_valid
      if english_word
        @result = "Congratulations! #{word.upcase} is a valid English word!"
      else
        @result = "Sorry but #{word.upcase} does not seem to be a valid English word..."
      end
    else
      @result = "Sorry but #{word.upcase} can't be built out of #{letters}"
    end
  end
end
