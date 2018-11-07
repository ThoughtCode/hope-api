# Providers API

Table of Contents:

- [Sign-Up- Facebook](#sign-up-facebook)

# Sign Up Facebook

Method: `POST`

URI: `/api/v1/customers/facebook`

Body:

```json
{
  "customer": {
    "facebook_access_token": "xxxxxx"
  }
}
```

## Return example on success, 200

```json
{
  "message": "Signed In successfully"
}
```
