class PagesController < ApplicationController
  def home; end

  def add_card
  	puts '\n\n\n\n\n\n\n\n\n\n\n\n'
  	puts params[:id]
  	puts '\n\n\n\n\n\n\n\n\n\n\n\n'
  	puts params[:email]
  	puts '\n\n\n\n\n\n\n\n\n\n\n\n'
  end
end
