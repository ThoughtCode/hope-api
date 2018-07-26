# Cities API

Table of Contents:

- [City Object Example](#city-object-example)
- [Index](#index)

# City Type object example

```json
{
  "city": {
    "data": [
      {
        "id": "1",
        "type": "city",
        "attributes": {
          "name":"Quito"
        }
      }
    ]
  }
}
```

## Index

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/cities`

### Return example on success, 200

```json
{
  "message": "Ciudades listadas exitosamente.",
  "city": {
    "data": [Returns an array of `City` object.]
  }
}

```