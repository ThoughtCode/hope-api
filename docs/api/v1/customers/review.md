# Review API

Table of Contents:

- [Review Object Example](#review-object-example)
- [Index](#index)
- [Create](#create)
- [Show](#show)


# Review object example

```json
{
    "message": "Calificaciones listadas exitosamente",
    "review": {
        "data": [
            {
                "id": "5ba32f28ae18d043bfa55ff0",
                "type": "review",
                "attributes": {
                    "id": 8,
                    "comment": "Buen cliente",
                    "qualification": 5,
                    "my_reviews": {
                        "data": {
                            "id": 8,
                            "type": "review",
                            "attributes": {
                                "owner_first_name": "Henry",
                                "owner_last_name": "Remache",
                                "owner_email": "henry2992@gmail.com",
                                "owner_avatar": {
                                    "url": null
                                },
                                "reviewee_first_name": "henry",
                                "reviewee_last_name": "remache",
                                "reviewee_email": "henry@donorbox.org",
                                "reviewee_avatar": {
                                    "url": null
                                }
                            }
                        }
                    }
                }
            }
        ]
    }
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

URI: `/api/v1/customers/jobs/:job_id/review`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

## Request example

```json
{
    review: { 
        "qualification": REVIEW_QUALIFICATION(Integer),
        "comment": REVIEW_COMMENT(String),
    }
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

## Customer Reviews

Method: `GET`

URI: `/api/v1/customers/agent/:agent_id/reviews` -> `agent_id is the agent.hashed_id`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

### Return example on success, 200

```json
{
  "message": "Calificación encontrada exitosamente.",
  "review": [Array of Review object]
}

```