class TasksController < ApplicationController
  before_action :require_login

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
