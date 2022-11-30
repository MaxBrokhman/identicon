defmodule Identicon do
  def main(input) do
    input
      |> hash_input
      |> pick_color

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
