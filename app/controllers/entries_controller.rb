class EntriesController < ApplicationController
  def index
    get_and_show_entries
  end

  def index_with_button
    get_and_show_entries
  end

  def show
    @entry = Entry.find_by_id(params[:id])
  end



  private

  def get_and_show_entries
    @entries = Entry.paginate(page: params[:page], per_page: 15).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end
end