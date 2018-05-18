# Service Types API

Table of Contents:

- [Service Type Object Example](#service-type-object-example)
- [Index](#index)
- [Show](#show)

# Service Type object example

```json
{
  "data": [
    {
      "id": "SERVICE_TYPE_ID",
      "type": "service_type",
      "attributes": {
        "name": "SERVICE_TYPE_NAME",
        "services": [`services object`]
      }
    }
  ]
}
```
# Index

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/service_types`

## Return example on success, 200

```json
{
  "message": "Service types successfully listed.",
  "data": [Returns an array of `Service Type` object.]
}

```

# Show

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/service_types/:id`

## Return example on success, 200

```json
{
  "message": "Service types successfully listed.",
  "data": {`Service Type` object.}
}

```