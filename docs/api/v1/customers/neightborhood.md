# Neightborhoods API

Table of Contents:

- [Neightborhood Object Example](#neightborhood-object-example)
- [Index](#index)

## Neightborhood object example

```json
{
  "id": "1",
  "type": "neightborhood",
  "attributes": {
    "name": "Monteserrin"
  }
}
```

## Index

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/cities/:city_id/neightborhoods`

### Return example on success, 200

```json
{
  "message": "Barrios listados exitosamente.",
  "city": {
    "data": [Returns an array of `Neightborhood` object.]
  }
}

```