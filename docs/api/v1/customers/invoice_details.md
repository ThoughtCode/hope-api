# Invoices API

Table of Contents:

- [Property Object Example](#property-object-example)
- [Index](#index)
- [Create](#create)
- [Destroy](#destroy)
- [Show](#show)

## Property object example

```json
{
  "invoice_detail": {
    "data": {
      "id": "4",
      "type": "invoice_detail",
      "attributes": {
        "email": "henry2992@hotmail.com",
        "identification": "0604354050",
        "identification_type": "cedula",
        "social_reason": "Henry Remache",
        "address": "Vos Andes y Mariano Echeverria",
        "telephone": "0996779124"
      }
    }
  }
}
```

## Index

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/invoice_details`

### Return example on success, 200

```json
{
  "message": "Detalles de facturacion listados exitosamente",
  "invoice_detail": {
    "data": [
      {
        "id": "1",
        "type": "invoice_detail",
        "attributes": {
          "email": "henry2992@hotmail.com",
          "identification": "0604354050",
          "identification_type": "cedula",
          "social_reason": "Henry Remache",
          "address": "Vos Andes y Mariano Echeverria",
          "telephone": "0996779124"
        }
      }
    ]
  }
}

```

### Return example on failure, 401

```
  Unauthorized

```

## Create

Method: `POST`

URI: `/api/v1/customers/invoice_details`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

body:

```json
{
  "message": "Detalles de facturacion creados exitosamente",
  "invoice_detail": {
    "data": {
      "id": "4",
      "type": "invoice_detail",
      "attributes": {
        "email": "henry2992@hotmail.com",
        "identification": "0604354050",
        "identification_type": "cedula",
        "social_reason": "Henry Remache",
        "address": "Vos Andes y Mariano Echeverria",
        "telephone": "0996779124"
      }
    }
  }
}
```

### Return example on success, 200

```json
{
  "message": "Detalles de facturacion creados exitosamente",
  "invoice_detail": {
      "data": {
          "id": "4",
          "type": "invoice_detail",
          "attributes": {
              "email": "henry2992@hotmail.com",
              "identification": "0604354050",
              "identification_type": "cedula",
              "social_reason": "Henry Remache",
              "address": "Vos Andes y Mariano Echeverria",
              "telephone": "0996779124"
          }
      }
  }
}
```

### Return example on failure, 422

```json
  unprocessable entity
```



## Destroy

Method: `DELETE`

URI: `/api/v1/customers/invoice_details/:id`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

### Return example on success, 200

```json
{
  "message": "Invoice Detail was deleted successfully.",
  "data": []
}

```

### Return example on failure, 404

```json
{
  "message": "Invoice Detail  does not exists.",
  "data": []
}
```