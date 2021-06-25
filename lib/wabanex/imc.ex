defmodule Wabanex.IMC do
  def calculate(%{"filename" => filename}) do
    filename
    |> File.read() #retorna um erro caso nao ache o camiho para o arquivo ou retorna um ok e o conteudo do arquivo
    |> handle_file()
  end

  defp handle_file({:ok, content}) do
    data=
      content
      |> String.split("\n")
      |> Enum.map(fn line -> parse_line(line) end)
      |> Enum.into(%{})

    {:ok, data}
  end

  defp handle_file({:error, _reason}) do
    {:error, "Eror while opening the file"}
  end

  defp parse_line(lline) do
    lline
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()

  end

  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end
