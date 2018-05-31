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
  "data": [{
      "id": "5b0498f5483a273007b2c209",
      "type": "job",
      "attributes": {
        "property_id": 3,
        "started_at": "2018-05-25T01:25:00.000Z",
        "finished_at": "2018-05-25T12:25:00.000Z",
        "duration": 11.0,
        "total": 85.0,
        "status": "pending", /* pending, accepted */
        "property": {
          "id":3,
          "name":"Working Up",
          "neightborhood_id":1,
          "p_street":"San Ignacio",
          "number":"123456",
          "s_street":"Gonzalo Suarez",
          "details":"Edificio Working Up",
          "additional_reference":null,
          "phone":null,
          "cell_phone":"1234567",
          "customer_id":1,
          "hashed_id":"5b047de0483a272c135ee438"
        },
        "agent":null,
        "job_details":[Job Details Example],
        "proposals":[]
      }
    }]
}
```

## Job Details Example

```json
{
  "id":219,
  "service_id":7,
  "value":1,
  "time":6.0,
  "price_total":5.0,
  "service": {
    "id":7,
    "service_type_id":2,
    "type_service":"base",
    "name":"Limpieza de apartamento de 2 cuartos",
    "quantity":false,
    "time":6.0,
    "price":5.0
  }
}
```

# Index

# Future Jobs

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/jobs?status=nextjobs&current_page=1&limit=4`

## Return example on success, 200



```json
{
  "message": "Trabajos listados exitosamente",
  "job": {
    "data": [{
      "id": "5b0498f5483a273007b2c209",
      "type": "job",
      "attributes": {
        "property_id": 3,
        "started_at": "2018-05-25T01:25:00.000Z",
        "finished_at": "2018-05-25T12:25:00.000Z",
        "duration": 11.0,
        "total": 85.0,
        "status": "pending", /* pending, accepted */
        "property": {
          "id":3,
          "name":"Working Up",
          "neightborhood_id":1,
          "p_street":"San Ignacio",
          "number":"123456",
          "s_street":"Gonzalo Suarez",
          "details":"Edificio Working Up",
          "additional_reference":null,
          "phone":null,
          "cell_phone":"1234567",
          "customer_id":1,
          "hashed_id":"5b047de0483a272c135ee438"
        },
        "agent":null,
        "job_details":[
          {"id":219,
          "service_id":7,
          "value":1,
          "time":6.0,
          "price_total":5.0,
          "service": {
            "id":7,
            "service_type_id":2,
            "type_service":"base",
            "name":"Limpieza de apartamento de 2 cuartos",
            "quantity":false,
            "time":6.0,
            "price":5.0
          }
        }],
        "proposals":[]
      }
    }]
  }
}

```

# History Jobs

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/jobs?status=history&current_page=1&limit=4`

## Return example on success, 200



```json
{
  "message": "Trabajos listados exitosamente",
  "job": {
    "data": [{
      "id": "5b0498f5483a273007b2c209",
      "type": "job",
      "attributes": {
        "property_id": 3,
        "started_at": "2018-05-25T01:25:00.000Z",
        "finished_at": "2018-05-25T12:25:00.000Z",
        "duration": 11.0,
        "total": 85.0,
        "status": "expired",
        "property": {
          "id":3,
          "name":"Working Up",
          "neightborhood_id":1,
          "p_street":"San Ignacio",
          "number":"123456",
          "s_street":"Gonzalo Suarez",
          "details":"Edificio Working Up",
          "additional_reference":null,
          "phone":null,
          "cell_phone":"1234567",
          "customer_id":1,
          "hashed_id":"5b047de0483a272c135ee438"
        },
        "agent":null,
        "job_details":[
          {"id":219,
          "service_id":7,
          "value":1,
          "time":6.0,
          "price_total":5.0,
          "service": {
            "id":7,
            "service_type_id":2,
            "type_service":"base",
            "name":"Limpieza de apartamento de 2 cuartos",
            "quantity":false,
            "time":6.0,
            "price":5.0
          }
        }],
        "proposals":[]
      }
    }]
  }
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