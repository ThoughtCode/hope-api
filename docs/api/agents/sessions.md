# Sessions API

Table of Contents:

- [Logging In](#logging-in)
- [Agent Object Example](#agent-object-example)
- [Sign Out](#signing-out)

# Logging in

Method: `POST`

URI: `/api/v1/agents/signin`

Body:

```javascript
{
  "agent": {
    "email": "EMAIL",
    "password": "PASSWORD"
  }
}
```

## Return example on success, 200

```
  Returns a `Agent` object.

```

## Return example on failure, 401

```
  Unauthorized

```


## Agent object example

```javascript
{
  "data": {
    "id": "ID",
    "type": "agent",
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

URI: `/api/v1/agent/signout`

headers["HTTP_AUTHORIZATION"] = "Token user.access_token"

### Return example on success, 200

```
  { message: 'Sign-out successful' }

```

### Return example on failure

```
  { 'Could not release the access token after successful logout' }
```
