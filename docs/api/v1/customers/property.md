# Properties API

Table of Contents:

- [Property Object Example](#property-object-example)
- [Index](#index)
- [Create](#create)
- [Update](#update)
- [Destroy](#destroy)
- [Show](#show)

## Property object example

```json
{
  "data": [
    {
      "id": "PROPERTY_HASHED_ID",
      "type": "property",
      "attributes": {
        "id": "PROPERTY_ID",
        "name": "PROPERTY_NAME",
        "p_street": "PROPERTY_P_STREET",
        "number": "PROPERTY_NUMBER",
        "s_street": "PROPERTY_S_STREET",
        "phone": "PROPERTY_PHONE",
        "neightborhood_id": "PROPERTY_NEIGHTBORHOOD_ID",
        "aditional_references0": "ADITIONAL_REFERENCE"
      }
    }
  ]
}
```

## Index

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/properties`

### Return example on success, 200

```json
{
  "message": "Property successfully listed.",
  "data": [Returns an array of `Property` object.]
}

```

### Return example on failure, 401

```
  Unauthorized

```

## Create

Method: `POST`

URI: `/api/v1/customers/properties`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

body:

```json
{
  "property": {
    "name": "PROPERTY_NAME",
    "neightborhood_id": "PROPERTY_NEIGHTBORHOOD_ID",
    "p_street": "PROPERTY_P_STREET",
    "s_street": "PROPERTY_S_STREET",
    "number": "PROPERTY_NUMBER",
    "phone": "PROPERTY_PHONE",
    "aditional_references0": "ADITIONAL_REFERENCE"
  }
}
```

### Return example on success, 200

```json
{
  "message": "Property created",
  "property": Property object
}

```

### Return example on failure, 422

```json
  unprocessable entity
```

## Update

Method: `PUT`

URI: `/api/v1/customers/properties/:id`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

### Return example on success, 200

```json
{
  "message": "Updated property successfully",
  "property": Property object
}

```

### Return example on failure, 422

```json
  unprocessable entity
```

### Return example on failure, 404

```json
{
  "message": "Property does not exists.",
  "data": []
}
```

## Destroy

Method: `DELETE`

URI: `/api/v1/customers/properties/:id`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

### Return example on success, 200

```json
{
  "message": "Property was deleted successfully.",
  "data": []
}

```

### Return example on failure, 404

```json
{
  "message": "Property does not exists.",
  "data": []
}
```

## Show

Method: `GET`

URI: `/api/v1/customers/properties/:id`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

### Return example on success, 200

```json
{
  "message": "Property found successfully.",
  "property": Property object
}

```

### Return example on failure, 404

```json
{
  "message": "Property does not exists.",
  "data": []
}
```