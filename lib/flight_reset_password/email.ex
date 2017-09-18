defmodule FlightResetPassword.Email do
  use Bamboo.Phoenix, view: FlightResetPassword.EmailView

  def reset_password_text_email(email_address,token,content) do
    from = Application.get_env(:flight_reset_password,FlightResetPassword.Mailer)[:username]
    new_email()
    |> to(email_address)
    |> from({content["from"],from})
    |> subject(content["subject"])
    |> text_body(
      content["body"]
      |> String.replace("<%= URL %>", token |> url(content))
    )
  end

  defp url(token,content) do
    "#{content["login_url"]}?token=#{token |> String.replace("=","") |> URI.encode}"
  end
end
