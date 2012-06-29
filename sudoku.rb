class SudokuBoard
  def initialize(board_str)
    @board = board_str.split("").map { |value| Cell.new(value.to_i) }
    @groups = []
    (generate_rows + generate_cols + generate_grids).each do |group_member_indices|
      group_cell_members = group_member_indices.map { |index| @board[index] }
      @groups << Group.new(group_cell_members)
    end
  end

  def solve
    puts cell_values
    while cell_values.include?('0')
      @board.each do |cell|
        cell.refresh_state
      end
      puts cell_values
      #pretty_print
    end

    to_s
  end

  def to_s
    @board.map { |cell| cell.value }.join
  end

  def generate_rows
    ar = (0..80).to_a
    Array.new(9).map { ar.shift(9) }
  end

  def generate_cols
    cols = Array.new(9,[])
    (0..80).to_a.each { |index| cols[index % 9] += [index] }
    cols
  end

  def generate_grids
    grids = Array.new(9,[])
    (0..80).to_a.each { |index| grids[(index / 9 / 3 * 3) + ((index % 9) / 3)] += [index]}
    grids
  end

end

class Group
  def initialize(members_ar) #pass in array of initial board settings
    @cells = members_ar
    @cells.each { |cell| cell.add_group(self)}
  end

  def other_cells_in_group(cell)
    @cells - [cell]
  end
end

class Cell
  attr_accessor :value
  def initialize(value)
    @value = value
  end
  def solved?
    @value > 0
  end
end

#board = SudokuBoard.new("619030040270061008000047621486302079000014580031009060005720806320106057160400030")
#board = SudokuBoard.new("096040001100060004504810390007950043030080000405023018010630059059070830003590007")
#board = SudokuBoard.new("396040001100369004504810396007951043931480005405023918710630459659174832043590167")
#board.solve