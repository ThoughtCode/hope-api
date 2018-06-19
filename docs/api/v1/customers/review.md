# Review API

Table of Contents:

- [Review Object Example](#review-object-example)
- [Index](#index)
- [Create](#create)
- [Show](#show)


# Review object example

```json
{
  "data": [
    {
        "id": "REVIEW_HASHED_ID",
        "type": "review",
        "attributes": {
            "id": "REVIEW_ID",
            "comment": "REVIEW_COMMENT",
            "qualification": "REVIEW_QUALIFICATION"
        }
    }
  ]
}
```

# Index

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/reviews`

## Return example on success, 200

```json
{
  "message": "Calificaciones listadas exitosamente",
  "data": [Returns an array of `Review` object.]
}

```

## Return example on failure, 401

```
  Unauthorized

```

# Create

Method: `POST`

URI: `/api/v1/customers/reviews`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

## Request example

```json
{
    review: { 
        "qualification": REVIEW_QUALIFICATION(Integer),
        "comment": REVIEW_COMMENT(String),
    },
    "job_id": JOB_HASHED_ID(String)
}

```

## Return example on success, 200

```json
{
  "message": "Calificación creada exitosamente",
  "review": Review object
}

```

## Return example on failure, 422

```json
  unprocessable entity
```


# Show

Method: `GET`

URI: `/api/v1/agents/reviews/:id` -> `id is the job.hashed_id` 

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

## Return example on success, 200

```json
{
  "message": "Calificación encontrada exitosamente.",
  "review": Review object
}

```

## Return example on failure, 404

```json
{
  "message": "Calificación no encontrada",
  "data": []
}
```