# Password API

Table of Contents:

- [Recover password Agent](#recover-password-agent)
- [Update password Agent](#update-password-agent)
- [App Recover password Agent](#app-recover-password-agent)
- [App Update password Agent](#app-update-password-agent)
# Recover Password Customer

Method: `POST`

URI: `/api/v1/agent/forgot_password`

Body:

```json
{
  "customer": {
    "email": "YOUR_EMAIL@email.com"
  }
}
```

## Return example on success, 200

```json
{
  "message": "Reset password instructions have been sent to email"
}
```

## Return example on failure, 404

```json
{
  "message":"Email does not exist"
}
```

# Update Password Customer

Method: `POST`

URI: `/api/v1/agent/update_password`

Body:

```json
{
  "reset_password_token": "rJkbLodj89SkiXgvoD3u",
  "password": "1234567",
  "password_confirmation": "1234567"
}
```

## Return example on success, 200

```json
{
  "message": "Reset password successfully"
}
```

It should redirect to login

## Return example on failure, 404

```json
{
  "message": {
    "reset_password_token": [
      "is invalid"
    ]
  }
}
```

# App Recover Password Customer

Method: `POST`

URI: `/api/v1/agent/recover_password`

Body:

```json
{
  "agent": {
    "email": "YOUR_EMAIL@email.com"
  }
}
```

## Return example on success, 200

```json
{
  "message": "Un pin ha sido enviado al correo especificado"
}
```

## Return example on failure, 404

```json
{
  "message":"El correo no existe"
}
```

# App Update Password Customer

Method: `POST`

URI: `/api/v1/agent/app_update_password`

Body:

```json
{
  "agent": {
    "email": "email@example.com",
    "mobile_token": "XXXXXX",
    "password": "1234567",
    "password_confirmation": "1234567"
  }
}
```

## Return example on success, 200

```json
{
  "message": "Contraseña reseteada exitosamente"
}
```

It should redirect to login

## Return example on failure, 404

```json
{
  "message": {
    "mobile_token": [
      "is invalid"
    ]
  }
}
```