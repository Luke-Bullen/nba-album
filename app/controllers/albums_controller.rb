class AlbumsController < ApplicationController
  attr_accessor :card_count

  def cards
  end

  def quizzes
  end

  def index
    @albums = Album.where(user_id: current_user.id)
    # @album = Album.where(user_id: current_user.id)
    # @album = Album.find(params[:id])


  # My added code from below - fix DRY later
  # sorting the albums by season - 2019, 2020, 2021
    all_album = Album.all
    all_album_array = []
    all_album.each do |album|
      all_album_array << album
    end
    @sorted_by_season = all_album_array.sort_by { |hash| hash[:season] }

    # lambda variable to count total number of cards in the album
    #  -> means lambda
    @total_card_count_of_album = ->(x) { Card.where(season: x).count }

    @number_of_owned_cards_in_album_count = -> { @total_card_count_of_album.where }

    
    # AlbumCard.where(counter: 1..).count
  end

  def show
    @album = Album.find(params[:id])
    index = params[:index].to_i || 0
    @batches = @album.cards.each_slice(6).to_a
    @cards = @batches[index] || []

    @team = @cards.first.team

    batches_count = @batches.count

    if batches_count == index + 1
      @next_index = nil
    else
      @next_index = index + 1
    end

    @prev_index = (index - 1).negative? ? nil : index - 1


    if index.odd?
      @color = "#1D428A" #this hash is the NBA $blue
    else
      @color = "#C8102E" #this hash is the NBA $blue
    end

    @quiz_first = Quiz.first.id
    @quiz_last = Quiz.last.id

    @season = @album.season
    @season_short = @season.chars.last(2).join
    @prev_season = @season_short.to_i - 1

    # sorting the albums by season - 2019, 2020, 2021
    all_album = Album.all
    all_album_array = []
    all_album.each do |album|
      all_album_array << album
    end
    @sorted_by_season = all_album_array.sort_by { |hash| hash[:season] }

  end

end
