# Sessions API

Table of Contents:

- [Logging In](#logging-in)
- [Customer Object Example](#customer-object-example)
- [Sign Out](#signing-out)

# Logging in

Method: `POST`

URI: `/api/v1/customers/signin`

Body:

```javascript
{
  "customer": {
    "email": "EMAIL",
    "password": "PASSWORD"
  }
}
```

## Return example on success, 200

```
  Returns a `Customer` object.

```

## Return example on failure, 401

```
  Unauthorized

```


## Customer object example

```javascript
{
  "data": {
    "id": "ID",
    "type": "customer",
    "attributes": {
      "first_name": "FIRST_NAME",
      "last_name": "LAST_NAME",
      "email": "EMAIL",
      "access_token": "XXXXXXXXXXXXXXXXXXXXX"
    }
  }
}
```

# Signing Out

Method: `DELETE`

URI: `/api/v1/customers/signout`

headers["HTTP_AUTHORIZATION"] = "Token user.access_token"

### Return example on success, 200

```
  { message: 'Sign-out successful' }

```

### Return example on failure

```
  { 'Could not release the access token after successful logout' }
```
