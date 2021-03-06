# Registrations API

Table of Contents:

- [Register Agent](#register-agent)
- [Register Mobile Token](#register-mobile-token)

# Register Agent

Method: `POST`

URI: `/api/v1/agents/signup`

Body:

```json
{
  "agent": {
    "first_name": "FIRST_NAME",
    "last_name": "LAST_NAME",
    "email": "YOUR_EMAIL@EMAIL.COM",
    "password": "XXXXXX",
    "password_confirmation": "XXXXXX",
    "national_id": "XXXXXXXXXX",
    "cell_phone": "XXX XXX XXXX",
    "birthday": "XX/XX/XXXX"
  }
}
```

## Return example on success, 200

```json
{
  "message": "Signed Up successfully!"
}
```

After sign up, it should login

## Return example on failure, 422

```json
{
  "message": {
    "email": [
      "has already been taken"
    ]
  }
}
```

```json
{
  "message": {
    "password_confirmation": [
      "doesn't match Password"
    ]
  }
}
```

```json
{
  "message": {
    "email": [
      "can't be blank"
    ]
  }
}
```


# Register Mobile Token

Method: `POST`

URI: `/api/v1/agents/add_mobile_token`

Body:

```json
{
  "agent": {
    "mobile_push_token": "xxxxxx",
  }
}
```

## Return example on success, 200

```json
{
  "message": "Mobile Token saved"
}
```

