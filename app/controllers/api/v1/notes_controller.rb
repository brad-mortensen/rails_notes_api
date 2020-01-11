class Api::V1::NotesController < ApplicationController
  before_action :find_note, only: [:show, :update, :destroy]

  def index
    @notes = Note.all
    render json: @notes
  end

  def show
    render json: @note
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      render json: @note
    else
      render json: {error: 'unable to create note'}, status: 400
    end
  end

  def update
    if @note
      @note.update(note_params)
      render json: {message: 'note updated'}, status: 200 
    else
      render json: {error: 'unable to update note'}, status: 400 
    end
  end

  def destroy
    @note = Note.find(paras[:id])
    if @note
      @note.destroy
      render json: {message: 'deleted note'}, status: 200
    else
      render json: {error: 'unable to delete note'}, status: 400
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :text_body)
  end

  def find_note 
    @note = Note.find(params[:id])
  end
end