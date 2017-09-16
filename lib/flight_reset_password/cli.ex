defmodule FlightResetPassword.CLI do
  def main(arguments) do
    {_opts, args, _} = OptionParser.parse(arguments)

    data = parse_data("FLIGHT_DATA")
    smtp = parse_data("SMTP")
    content = parse_data("EMAIL")
    #credential = parse_data("FLIGHT_CREDENTIAL")

    Application.put_env(:flight_reset_password, FlightResetPassword.Mailer,
      adapter: Bamboo.SMTPAdapter,
      server: smtp["server"],
      port: smtp["port"],
      username: smtp["user"],
      password: smtp["password"],
      tls: :if_available, # can be `:always` or `:never`
      ssl: false, # can be `true`
      retries: 1
    )

    case args do
      ["send-email" | _] ->
        case {data["email"] || "",data["token"] || ""} do
          {"",""} -> "no email and token" |> puts_result(104)
          {"",_}  -> "no email" |> puts_result(104)
          {_,""}  -> "no token" |> puts_result(104)
          {email,token}  ->
            FlightResetPassword.Email.reset_password_text_email(email,token,content)
            |> FlightResetPassword.Mailer.deliver_now
            %{"message" => "ok"} |> puts_result
        end
      _ -> "unknown command: #{arguments |> inspect}" |> puts_error
    end
  end

  defp parse_data(key) do
    System.get_env(key)
    |> case do
      nil -> %{}
      raw ->
        raw
        |> Poison.decode!
        |> case do
          nil -> %{}
          data -> data
        end
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
