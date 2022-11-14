require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    # display a new game with new letters and input for words
    @list = []
    alphabet = ('A'..'Z').to_a
    10.times do
      @list.push(alphabet.sample)
    end
  end

  def score
    # the form has a post method to get input from user
    session
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_serialized = URI.open(url).read
    @word = JSON.parse(word_serialized)
    @user_word = params[:word].upcase.chars
    list_of_letters = params[:letters].split
    @user_word.select! { |letter| list_of_letters.include?(letter) }
  end

  def session
    @current_session = session[:session_id]
  end
end
