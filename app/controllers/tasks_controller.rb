class TasksController < ApplicationController

  def create
    if params[:sku].present?
      @album = Album.where(sku: params[:sku]).first
      render layout: false
    elsif params[:id].present?
      @album = Album.find params[:id]
      render layout: false
    end
  end
end
