# Proposals API

Table of Contents:

- [Show](#show)
- [Accepted](#accepted)
- [Refused](#refused)

# Show

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/jobs/:job_id/proposals/:id`

## return example on success

Body:

```json
{
  "message": "Propuesta listadas exitosamente",
  "proposal": {
    "data": {
      "id": "XXXXXXXXXXXXXXXXXXXXXX",
      "type": "proposal",
      "attributes": {
        "id": X,
        "job": {
          "id": XX,
          "property_id": X,
          "duration": X,
          "status": "pending", // ["pending", "accepted", "refused", "expired"]
          "agent_id": XXX,
          "total": XXX,
          "hashed_id": "XXXXXXXXXXXXXXXXXXXxxx",
          "started_at": "2018-05-06T23:54:21.000Z",
          "finished_at": "2018-05-07T04:54:21.000Z"
        }
      }
    }
  }
}
```

# Accepted

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/jobs/:job_id/accepted/:id`

## return example on success

Body:

```json
{
  "message": "Propuesta aceptada exitosamente",
  "data": []
}
```

# Refused

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/jobs/:job_id/refused/:id`

## return example on success

Body:

```json
{
  "message": "Propuesta rechazada exitosamente",
  "data": []
}
```
