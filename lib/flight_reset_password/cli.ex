defmodule FlightResetPassword.CLI do
  def main(arguments) do
    {_opts, args, _} = OptionParser.parse(arguments)

    data = parse_data()

    case args do
      ["send-email" | _] ->
        case data["email"] do
          nil -> "no email" |> puts_result(104)
          "" ->  "no email" |> puts_result(104)
          email ->
            case data["token"] do
              nil -> "no token" |> puts_result(104)
              "" ->  "no token" |> puts_result(104)
              token ->
                FlightResetPassword.Email.reset_password_text_email(email,token)
                |> FlightResetPassword.Mailer.deliver_now
                %{"message" => "ok"} |> puts_result
            end
        end
    end
  end

  defp parse_data do
    System.get_env("FLIGHT_DATA")
    |> Poison.decode!
    |> case do
      nil -> %{}
      data -> data
    end
  end

  defp puts_result(data) do
    IO.puts(data |> Poison.encode!)
  end
  defp puts_result(message,status) do
    IO.puts(message)
    System.halt(status)
  end
  defp puts_error(message) do
    IO.puts(:stderr, "#{__MODULE__}: [ERROR] #{message}")
    System.halt(1)
  end
end
