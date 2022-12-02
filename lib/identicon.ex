defmodule Identicon do
  def main(input) do
    input
      |> hash_input
      |> pick_color
      |> build_grid
      |> filter_odd_squares
  end

  def filter_odd_squares(image) do
    %Identicon.Image{grid: grid} = image
   updatedGrid = Enum.filter(grid, fn({code, _idx}) ->
      rem(code, 2) == 0
    end)
    %Identicon.Image{image | grid: updatedGrid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def build_grid(image) do
    %Identicon.Image{hex: hex} = image
    grid = hex
      |> Enum.chunk_every(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index
    %Identicon.Image{image | grid: grid}
  end

  def pick_color(image) do
    %Identicon.Image{hex: [red, green, blue | _tail]} = image
    %Identicon.Image{image | color: {red, green, blue}}
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
