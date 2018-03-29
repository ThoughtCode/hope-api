# Update API

Table of Contents:

- [Update Agent](#update-agent)

# Update Agent

Method: `PUT`

URI: `/api/v1/agents/update`

HTTP HEADER:

['HTTP-AUTHORIZATION'] = "Token sdoifhFAKEzdslhvlzirug(access_token)"

Body:

```json
{
  "customer": {
    "access_token": "gaegfvakFAKEjdnaoihcpaidifnaFAKEdkjf",
    "first_name": "FIRST_NAME",
    "last_name": "LAST_NAME",
    "email": "YOUR_EMAIL@EMAIL.COM",
    "password": "XXXXXX",
    "national_id": "123456",
    "cell_phone": "1234567890",
    "birthdday": "xx/xx/xxxx"
  }
}
```

## Return example on success, 200

```json
{
  "message": "Agent have been updated successfully."
}
```

## Return example on failure, 422

```json
{
  "message": "Unprocessable Entity"
}
```

## Return example on failure, 404

```json
{
  "message": "Agent not found."
}
```