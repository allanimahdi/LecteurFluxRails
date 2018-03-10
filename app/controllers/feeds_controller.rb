class FeedsController < ApplicationController
  before_action :load_entries, :set_feed, only: [:show, :edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all

  end

  def load_entries
    @entries ||= Entry.all
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @entry = Entry.new
    @feed = Feed.find(params[:id])
  #  @result = Feedjira::Feed.fetch_and_parse "#{@feed.url}"

    require 'rss'
    @rss = RSS::Parser.parse("#{@feed.url}",false)
 #   puts "ceci est le resultat",@rss
=begin
    puts result.title
    puts result.url
    puts result.description
      # puts result.entries
  #  @entry = @feed.entry



    @entry.feed_id = @feed.id
   @entry.pulished = DateTime.now
    @entry.content = result.description
    @entry.title = result.title


      #  @entry_feed_id = @feed_id
      # puts "entry title",@entry_title
      #  puts "entry description",@entry_description
   # puts result
   # puts "entry feed id",@entry_feed_id
   # puts "het el kol ","#{result.entries}"

#   @entry.save
    Rails.logger.info(@entry.errors.inspect)

=end
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)
    require 'rss'

    urlentite = feed_params[:url]
    puts "ceci est le lien ",urlentite




    respond_to do |format|
      if @feed.save
        format.html { redirect_to :controller => 'entries', :action => 'index' , notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end

    puts "ceci est le feed ID",@feed.id
    rss = RSS::Parser.parse(urlentite,false)
    rss.items.each do |item|
      puts "ceci est item title ",item.title
      @entry = Entry.new
      @entry.title = item.title
      @entry.content = item.description
      @entry.feed_id = @feed.id
      @entry.pulished = item.date
      @entry.url = item.link
      @entry.save
      Rails.logger.info(@entry.errors.inspect)
    end


  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:name, :url)
    end
    def entry_params
      params.require(:entry).permit(:content, :title, :feed_id,:pulished,:url)
    end
end
