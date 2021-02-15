require "open-uri"

class GamesController < ApplicationController
  def new
    vowels = ["A", "E", "I", "O", "U"]
    @letters = []

    5.times do
      @letters << ("A".."Z").to_a.sample
      @letters << vowels.sample
    end
  end

  def score
    @letters = params[:letters].split
    @word = params[:word].upcase
    @included = included?(@word, @letters)
    @english = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
    # false
  end
end
