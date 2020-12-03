defmodule DoorPassword do
  @door_id "cxdnnyjw"

  def run(limit) do
    calculate_md5(Enum.to_list(0 .. limit), [])
    |> Enum.reject(fn(md5) -> !String.starts_with?(md5, "00000") end)
    |> Enum.map_join("", fn(md5) -> String.at(md5, 5) end)


    #if limit < 0 do
    #  password
    #else
    #  digest = :crypto.hash(:md5, Enum.join([@door_id, to_string(limit)])) |> Base.encode16 |> String.downcase
    #  cond do
    #    String.starts_with?(digest, "00000") ->
    #      char = String.at(digest, 5)
    #      run(Enum.join([char, password]), limit - 1)
    #    true ->
    #      run(password, limit - 1)
    #  end
    #end
  end

  defp calculate_md5([head | tail], digests) do
    md5 = :crypto.hash(:md5, Enum.join([@door_id, to_string(head)])) |> Base.encode16
    calculate_md5(tail, digests ++ [md5])
  end

  defp calculate_md5([], digests) do
    digests
  end
end

IO.puts DoorPassword.run(10_000_000)
