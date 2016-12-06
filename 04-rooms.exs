defmodule Rooms do
  def run do
    File.read!("04-rooms.txt")
    |> String.split
    #|> Enum.take(5)
    #|> Enum.reduce(0, fn(room, acc) -> acc + sector_id(room) end)
    |> Enum.map(fn(room) -> [ to_string(room), decode(room) ] end)
  end

  defp decode(room) do
    [[_, name, sector_id, checksum]] = Regex.scan(~r/^(.+)-(\d+)\[(\w+)\]$/, room)

    to_charlist(name)
    |> rotate(elem(Integer.parse(sector_id), 0))
  end

  defp sector_id(room) do
    [[_, name, sector_id, checksum]] = Regex.scan(~r/^(.+)-(\d+)\[(\w+)\]$/, room)

    IO.puts "#{checksum} - #{calculate_checksum(to_charlist(String.replace(name, "-", "")))}"
    cond do
      checksum == calculate_checksum(to_charlist(String.replace(name, "-", ""))) ->
        elem(Integer.parse(sector_id), 0)
      true -> 0
    end
  end

  defp calculate_checksum(name) do
    Enum.uniq(name)
    |> Enum.reduce([], fn(letter, acc) -> acc ++ [{count_occurrences(name, letter), letter}] end)
    |> Enum.sort(&sorter/2)
    |> Enum.take(-5)
    |> Enum.reverse
    |> Enum.map(fn(tuple) -> to_string([elem(tuple, 1)]) end)
    |> Enum.join
  end

  defp rotate([h | t], times) do
    case h do
      ?- -> rotate_dash(times) ++ rotate(t, times)
      _ -> rotate_letter(h, times) ++ rotate(t, times)
    end
  end

  defp rotate([], times) do
    ''
  end

  defp rotate_letter(letter, times) do
    [rem((letter - 97) + times, 26) + 97]
    |> to_charlist
  end

  defp rotate_dash(times) do
    case rem(times, 2) do
      0 -> '-'
      1 -> ' '
    end
  end

  defp count_occurrences(name, letter) do
    Enum.count(name, fn(l) -> l == letter end)
  end

  defp sorter(a, b) do
    cond do
      elem(a, 0) < elem(b, 0) -> true
      elem(a, 0) == elem(b, 0) -> elem(a, 1) >= elem(b, 1)
      elem(a, 0) > elem(b, 0) -> false
    end
  end
end

Rooms.run
|> Enum.join("\n")
|> IO.puts
