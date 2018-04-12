# Services API

Table of Contents:

- [Service Object Example](#service-object-example)
- [Index](#index)

# Service Type object example

```json
{
  "data": [
    {
      "id": "SERVICE_ID",
      "type": "service",
      "attributes": {
        "name": "SERVICE_NAME",
        "type_service": "SERVICE_TYPE_SERVICE",
        "quantity": "SERVICE_QUANTITY",
        "time": "SERVICE_TIME",
        "price": "SERVICE_PRICE"
      }
    }
  ]
}
```
# Index

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/service_types/:service_type_id/services`

## Return example on success, 200

```json
{
  "message": "Services successfully listed.",
  "data": [Returns an array of `Service` object.]
}

```