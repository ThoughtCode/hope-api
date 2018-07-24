# Review API

Table of Contents:

- [Review Object Example](#review-object-example)
- [Index](#index)
- [Create](#create)
- [Show](#show)

## Review object example

```json
{
  "id": "5b490001dd135a50d9f9a22d",
  "type": "review",
  "attributes": {
    "id": 41,
    "comment": "adsasdasd",
    "qualification": 5,
    "owner": {
      "data": {
        "id": "1",
        "type": "customer",
        "attributes": {
          "first_name": "Rainiero",
          "last_name": "Romero",
          "email": "rainieromadrid@gmail.com",
          "access_token": "70925c27142314a4d8b850cf8c4a46ab",
          "avatar": {
            "url": "https://noc-noc.s3.amazonaws.com/uploads/agent/avatar/1/apartment-blinds-cabinets-349749__1_.jpg"
          },
          "national_id": "22399185",
          "cell_phone": "1234556789",
          "hashed_id": null,
          "rewiews_count": 2,
          "rewiews_average": 5,
          "rewiews": [
            {
              "id": 42,
              "hashed_id": "5b49006edd135a50d9f9a22e",
              "job_id": 70,
              "owner_type": "Customer",
              "owner_id": 1,
              "comment": "Muy bueno",
              "qualification": 5
            },
          ]
        }
      }
    }
  }
}
```

## Index

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/reviews`

### Return example on success, 200

```json
{
  "message": "Calificaciones listadas exitosamente",
  "data": [Returns an array of `Review` object.]
}

```

### Return example on failure, 401

```json
  Unauthorized

```

## Create

Method: `POST`

URI: `/api/v1/agents/reviews`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

### Request example

```json
{
    review: { 
        "qualification": REVIEW_QUALIFICATION(Integer),
        "comment": REVIEW_COMMENT(String),
    },
    "job_id": JOB_HASHED_ID(String)
}

```

### Return example on success, 200

```json
{
  "message": "Calificación creada exitosamente",
  "review": Review object
}

```

### Return example on failure, 422

```json
  unprocessable entity
```

## Show

Method: `GET`

URI: `/api/v1/agents/reviews/:id` -> `id is the job.hashed_id`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

### Return example on success, 200

```json
{
  "message": "Calificación encontrada exitosamente.",
  "review": Review object
}

```

### Return example on failure, 404

```json
{
  "message": "Calificación no encontrada",
  "data": []
}
```

## Customer Reviews

Method: `GET`

URI: `/api/v1/agents/customer/:customer_id/reviews` -> `customer_id is the customer.hashed_id`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

### Return example on success, 200

```json
{
  "message": "Calificación encontrada exitosamente.",
  "review": [Array of Review object]
}

```