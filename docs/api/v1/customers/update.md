# Update API

Table of Contents:

- [Update customers](#update-customers)

## Update customers

Method: `PUT`

URI: `/api/v1/customers/update`

HEADER: `['HTTP-AUTHORIZATION'] = "Token (access_token)"`

Body:

```json
{
  "customers": {
    "first_name": "FIRST_NAME",
    "last_name": "LAST_NAME",
    "email": "YOUR_EMAIL@EMAIL.COM",
    "cell_phone": "1234567890",
  }
}
```

### Return example on success, 200

```json
{
  "message": "Se ha actualizado sastifactoriamente"
}
```

### Return example on failure, 422

```json
{
  "message": "Unprocessable Entity"
}
```

### Return example on failure, 404

```json
{
  "message": "customers not found."
}
```

## Update customers Avatar

Method: `PUT`

Header: `['HTTP-AUTHORIZATION'] = "Token (access_token)"`

Content-Type: multipart/form-data;

URI: `/api/v1/customers/update`

Body:

```json
{
  "customers": {
    "avatar": file,
  }
}
```

### Return example on success, 200

```json
{
  "message": "Se ha actualizado sastifactoriamente"
}
```

## Get Current customers

Method: `GET`

Header: `['HTTP-AUTHORIZATION'] = "Token (access_token)"`

URI: `/api/v1/customers/current`

### Return example on success, 200

```json
{
  "message": "Usuario listado exitosamente.",
  "customers": {
    "data": {
      "id": "28",
      "type": "customers",
      "attributes": {
        "first_name": "Rai",
        "last_name": "Romero",
        "email": "rainieromadrid@gmail.com",
        "access_token": "61a1027d7fc02baf6a5f43001133c685",
        "avatar": {
          "url": "https://noc-noc.s3.amazonaws.com/uploads/customers/avatar/28/Rai.jpeg"
        },
        "national_id": "22399185",
        "cell_phone": "1234567890",
        "rewiews_count": 0,
        "rewiews_average": 0,
        "rewiews": {
          "data": []
        }
      }
    }
  }
}
```

## Change customers Password

Method: `PUT`

Header: `['HTTP-AUTHORIZATION'] = "Token (access_token)"`

URI: `/api/v1/customers/change_password`

body:

```json
{
  "customers": {
    "current_password": xxxxx,
    "password": xxxxx,
    "password_confirmation": xxxx,
  }
}
```

### Return example on success, 200

```json
{
  "message": "Contraseña actualizada exitosamente",
}
```