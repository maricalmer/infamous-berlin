class Mirror < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def default_grid_position(index)
    factor = pull_factor(index)
    fraction = index / 12
    case factor
    when 0 then update(grid_x: "8", grid_y: ((fraction - 1) * 12 + 10).to_s, grid_w: "4", grid_h: "2")
    when 1 then update(grid_x: "0", grid_y: (fraction * 12).to_s, grid_w: "4", grid_h: "4")
    when 2 then update(grid_x: "4", grid_y: (fraction * 12).to_s, grid_w: "3", grid_h: "6")
    when 3 then update(grid_x: "7", grid_y: (fraction * 12).to_s, grid_w: "2", grid_h: "4")
    when 4 then update(grid_x: "9", grid_y: (fraction * 12).to_s, grid_w: "3", grid_h: "4")
    when 5 then update(grid_x: "0", grid_y: (fraction * 12 + 4).to_s, grid_w: "4", grid_h: "2")
    when 6 then update(grid_x: "7", grid_y: (fraction * 12 + 4).to_s, grid_w: "5", grid_h: "2")
    when 7 then update(grid_x: "0", grid_y: (fraction * 12 + 6).to_s, grid_w: "3", grid_h: "4")
    when 8 then update(grid_x: "3", grid_y: (fraction * 12 + 6).to_s, grid_w: "2", grid_h: "4")
    when 9 then update(grid_x: "5", grid_y: (fraction * 12 + 6).to_s, grid_w: "3", grid_h: "6")
    when 10 then update(grid_x: "8", grid_y: (fraction * 12 + 6).to_s, grid_w: "4", grid_h: "4")
    when 11 then update(grid_x: "0", grid_y: (fraction * 12 + 10).to_s, grid_w: "5", grid_h: "2")
    end
  end

  private

  def pull_factor(index)
    float = index / 12.0
    decimals = BigDecimal(float.to_s).modulo(1).to_f
    return (decimals / 0.0833333333333335).round
  end
end
