# Proposals API

Table of Contents:

- [Index](#index)
- [Create](#create)
- [Destroy](#destroy)

# Index

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/proposals`

## return example on success

Body:

```json
{
  "message": "Propuestas listadas exitosamente",
  "proposal_for_agents": {
    "data": [
      {
        "id": "XXXXXXXXXXXXXXXXXXXXXX",
        "type": "proposal_for_agents",
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
    ]
  }
}
```

# Create

Method: `POST`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/jobs/:job_id/proposals`

## return example on success

Body:

```json
{
  "message": "Se ha postulado exitosamente",
  "data": []
}
```

# Destroy

Method: `POST`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/jobs/:job_id/proposals/:id`

## return example on success

Body:

```json
{
  "message": "La propuesta ha sido eliminada exitosamente",
  "data": []
}
```
