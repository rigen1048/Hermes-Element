# Change these two values
MATRIX_BOT_USER='@your-bot:matrix.org'
MATRIX_ALLOWED_USER='@your-personal-user:matrix.org'

# Keep these exactly as shown
MATRIX_HOMESERVER='https://matrix-client.matrix.org'
MATRIX_DEVICE_ID='HERMES_BOT'

# Enter the bot account password invisibly
read -rsp 'Bot account password: ' MATRIX_BOT_PASSWORD
echo

# Create a dedicated Hermes login/device and capture the response
MATRIX_LOGIN_RESPONSE="$(
  jq -n \
    --arg user "$MATRIX_BOT_USER" \
    --arg password "$MATRIX_BOT_PASSWORD" \
    --arg device_id "$MATRIX_DEVICE_ID" \
    '{
      type: "m.login.password",
      identifier: {
        type: "m.id.user",
        user: $user
      },
      password: $password,
      device_id: $device_id,
      initial_device_display_name: "Hermes Agent"
    }' |
  curl -fsS \
    -X POST "$MATRIX_HOMESERVER/_matrix/client/v3/login" \
    -H 'Content-Type: application/json' \
    --data-binary @-
 )"

# Extract the new dedicated Hermes access token
MATRIX_ACCESS_TOKEN="$(
  printf '%s' "$MATRIX_LOGIN_RESPONSE" | jq -er '.access_token'
)" || {
  echo "Login failed:"
  printf '%s\n' "$MATRIX_LOGIN_RESPONSE" | jq .
  exit 1
}

echo
echo 'Fill the Hermes form with:'
echo
printf 'MATRIX HOMESERVER URL: %s\n' "$MATRIX_HOMESERVER"
printf 'MATRIX ACCESS TOKEN:   %s\n' "$MATRIX_ACCESS_TOKEN"
printf 'MATRIX USER ID:        %s\n' "$MATRIX_BOT_USER"
printf 'ALLOWED USER IDS:      %s\n' "$MATRIX_ALLOWED_USER"
printf 'MATRIX DEVICE ID:      %s\n' "$MATRIX_DEVICE_ID"
echo 'MATRIX PASSWORD:        leave blank'
echo 'MATRIX RECOVERY KEY:    leave blank unless using E2EE'

# Remove sensitive values from the current shell variables
unset MATRIX_BOT_PASSWORD MATRIX_LOGIN_RESPONSE

