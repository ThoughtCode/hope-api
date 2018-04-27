# Update API

Table of Contents:

- [Update Customer](#update-customer)

# Update Customer

Method: `PUT`

URI: `/api/v1/customers/update`

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
    "birthdday": "xx/xx/xxxx",
    "file": File
  }
}
```

## Return example on success, 200

```json
{
  "message": "Customer have been updated successfully."
}
```

## Return example on failure, 422

```json
{
  "message": "Unprocessable Entity"
}
```

## Return example on failure, 401

```json
{
  "message": "HTTP Token: Access denied."
}
```