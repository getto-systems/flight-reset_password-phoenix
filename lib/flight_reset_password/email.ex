defmodule FlightResetPassword.Email do
  use Bamboo.Phoenix, view: FlightResetPassword.EmailView

  def reset_password_text_email(email_address,token) do
    from = Application.get_env(:flight_reset_password,FlightResetPassword.Mailer)[:username]
    new_email()
    |> to(email_address)
    |> from({System.get_env("EMAIL_FROM"),from})
    |> subject(System.get_env("EMAIL_SUBJECT"))
    |> text_body(
      System.get_env("EMAIL_BODY")
      |> String.replace("\\n","\n")
      |> String.replace("#URL#", token |> url)
    )
  end

  defp url(token) do
    "#{System.get_env("LOGIN_URL")}?token=#{token |> String.replace("=","") |> URI.encode}"
  end
end
