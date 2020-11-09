require 'open-uri'

class GamesController < ApplicationController
  def new
    @grid = Array.new(rand(4..8)) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:score]
    letter_array = params[:letters].split("")
    @includes = params[:score].chars.all? { |letter| params[:score].count(letter) <= letter_array.count(letter) }

    @englishword = english?(@word)

   if @englishword == true && @includes
     @try = "word is valid"
   elsif @englishword == false && @includes
     @try = "word exists in the grid but is unvalid"
   else
     @try = "word is unvalid"
   end
  end

  private

  def english?(word)

  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)

  json["found"]
  end
end
