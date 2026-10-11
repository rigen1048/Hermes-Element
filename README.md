# Hermes-Element

A simple helper for connecting **Hermes** to Matrix using Element.

This script only helps you get the Matrix details needed by Hermes. It does **not** set up Hermes, a VPS, OpenRouter, or Matrix accounts.

---

## Before you start

You need:

- Hermes already set up and running.
- Two Matrix accounts on `matrix.org`:
  - One for **you**.
  - One separate account for the **Hermes bot**.
- `curl` and `jq` installed on your computer.

> Both accounts must be on the same homeserver.  
> A Matrix user ID looks like `@your-name:matrix.org`.

---

## Quick start

1. Clone the repository:

   ```bash
   git clone https://github.com/rigen1048/Hermes-Element.git
   cd Hermes-Element
   ```

2. Open `fill_up.sh` and replace the two values near the top:

   ```bash
   MATRIX_BOT_USER='@your-bot:matrix.org'
   MATRIX_ALLOWED_USER='@your-personal-user:matrix.org'
   ```

   - `MATRIX_BOT_USER`: the Matrix username for the Hermes bot.
   - `MATRIX_ALLOWED_USER`: your own Matrix username, which Hermes will be allowed to talk to.

3. Make the script executable and run it:

   ```bash
   chmod +x fill_up.sh
   ./fill_up.sh
   ```

4. Enter the **bot account password** when prompted. It will be hidden while typing.

5. Copy the displayed values into Hermes & follow the instruction

---

## Security

- Treat the access token like a password.
- Never share it in chats, screenshots, GitHub issues, or public logs.
- Use a dedicated Matrix account for Hermes, not your personal account.
- If the token is exposed, remove the `HERMES_BOT` session from your Matrix account settings and run the script again.

---

## Troubleshooting

- **Login failed:** Check the bot username, password, and that both accounts are on `matrix.org`.
- **Invalid token in Hermes:** Make sure the homeserver URL, access token, bot user ID, and device ID were copied exactly. Do not enter the bot password when using the access token.
- **`jq: command not found`:** Install `jq`, then run the script again.
- **Make homeserver url is correct** : Element All setting -> help & about -> under Advance
---

## Other homeservers

This script is configured for `matrix.org`. To use another server, change `MATRIX_HOMESERVER` in the script and ensure that server supports the Matrix login API.

---

## License

This project is licensed under the [Apache License 2.0](LICENSE).
