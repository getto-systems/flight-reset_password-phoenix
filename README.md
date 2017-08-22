# flight-reset_password-phoenix

reset_password module for getto/flight using phoenix

## usage

### find

```
echo $data
# => {
  "email": <email>,
  "token": <token>
}

docker run \
  -e FLIGHT_DATA="$data" \
  -e EMAIL_FROM="EMAIL FROM USER NAME" \
  -e EMAIL_SUBJECT="SUBJECT" \
  -e EMAIL_BODY="BODY" \
  -e LOGIN_URL="http://LOGIN_URL/" \
  getto/flight-reset_password-phoenix \
  send-email

# => {"message": "ok"}
```

## pull

```
docker pull getto/flight-reset_password-phoenix
```

## build

```
docker build -t getto/flight-reset_password-phoenix .
```
