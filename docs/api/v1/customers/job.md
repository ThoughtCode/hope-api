# Jobs API

Table of Contents:

- [Object Example](#Object-example)
- [Index](#index)
- [Create](#create)
- [Update](#update)
- [Destroy](#destroy)
- [Show](#show)


# Object example

## Job Object Example

```json
{
  "data": [
    {
      "id": "JOB_ID",
      "type": "job",
      "attributes": {
        "property_id": "JOB_PROPERTY_ID",
        "date": "JOB_DATE",
        "duration": "JOB_DURATION",
        "total": "JOB_TOTAL",
        "status": "JOB_STATUS",
        "job_details": [
          {
            Job Details Object
          }
        ]
      }
    }
  ]
}
```

## Job Details Example

```json
{
  "id": "JOB_DETAIL_ID",
  "service_id": "JOB_DETAIL_SERVICE_ID",
  "value": "JOB_DETAIL_VALUE",
  "time": "JOB_DETAIL_TIME",
  "price_total": "JOB_DETAIL_PRICE_TOTAL",
  "service": {
    "id": "SERVICE_ID",
    "service_type_id": "SERVICE_SERVICE_TYPE_ID",
    "type_service": "SERVICE_TYPE_SERVICE",
    "name": "SERVICE_NAME",
    "quantity": "SERVICE_QUANTITY",
    "time": "SERVICE_TIME",
    "price": "SERVICE_PRICE"
  }
}
```

# Index

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/jobs`

## Return example on success, 200

```json
{
  "message": "Job successfully listed.",
  "data": [Returns an array of `Job` object.]
}

```

## Return example on failure, 401

```
  Unauthorized

```

# Create

Method: `POST`

URI: `/api/v1/customers/jobs`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

## Return example on success, 200

```json
{
  "message": "Job created",
  "job": Job object
}

```

## Return example on failure, 422

```json
  unprocessable entity
```

# Update

Method: `PUT`

URI: `/api/v1/customers/jobs/:id`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

## Return example on success, 200

```json
{
  "message": "Updated job successfully",
  "job": Job object
}

```

## Return example on failure, 422

```json
  unprocessable entity
```

## Return example on failure, 404

```json
{
  "message": "Job does not exists.",
  "data": []
}
```

# Destroy

Method: `DELETE`

URI: `/api/v1/customers/jobs/:id`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

## Return example on success, 200

```json
{
  "message": "Job was deleted successfully.",
  "data": []
}

```

## Return example on failure, 404

```json
{
  "message": "Job does not exists.",
  "data": []
}
```

# Show

Method: `GET`

URI: `/api/v1/customers/jobs/:id`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

## Return example on success, 200

```json
{
  "message": "Job found successfully.",
  "job": Job object
}

```

## Return example on failure, 404

```json
{
  "message": "Job does not exists.",
  "data": []
}
```