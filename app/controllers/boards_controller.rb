class BoardsController < ApplicationController
  def index
    @all = false
    @boards
    if (params[:all]) 
      @all = true
      @boards = Board.order("created_at DESC").limit(10)
    else
      @page = params[:page]
      @boards = Board.order("created_at DESC").paginate(page: @page, per_page: 10)
    end
  end

  def show
    @board = Board.find(params[:id])
    @mins = {}
    @board.board_mines.each do |mine|
      @mins["#{mine.row}-#{mine.col}"] = true;
    end
  end
  
  def new
    @board = Board.new
  end
  
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if !@board.save
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      else
        spaces = @board.width * @board.height
        mins = Array.new(spaces, 0)
        for i in 0..(@board.mine_num - 1)
          j = rand(spaces)
          while mins[j] == 1
            j += 1
          end
          mins[j] = 1
          spaces -= 1
        end
        boardMines = []
        for i in 0..(mins.length)
          if (mins[i] == 1)
            boardMines.push({board_id: @board.id, row: i / @board.width, col: i % @board.width})
          end
        end
        BoardMine.insert_all(boardMines)
        format.html { redirect_to @board, notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :user_email, :height, :width, :mine_num)
  end
end
