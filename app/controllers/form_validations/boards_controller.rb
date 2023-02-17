class FormValidations::BoardsController < BoardsController
  def create
    @board.assign_attributes(board_params)
    @board.validate
    respond_to do |format|
      format.text { render partial: 'boards/form', locals: { board: @board }, formats: [:html] } 
    end
  end