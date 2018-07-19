# Proposals API

Table of Contents:

- [Proposal Object Example](#proposal-object-example)
- [Show](#show)
- [Accepted](#accepted)
- [Refused](#refused)

## Object Example

```json
{
  "proposal": {
    "data": {
      "id": "5b4e5d768f3bd20004c690d2",
      "type": "proposal",
      "attributes": {
        "id": 54,
        "job": {
          "id": 115,
          "property_id": 23,
          "duration": 4.0,
          "agent_id": null,
          "total": 145.6,
          "hashed_id": "5b4e4262e0cb200004f52dba",
          "started_at": "2018-07-19T19:23:52.542Z",
          "finished_at": "2018-07-19T23:23:52.542Z",
          "status": "pending",
          "frequency": "fortnightly",
          "details": ""
        },
        "agent": {
          "data": {
            "id": "29",
            "type": "agent",
            "attributes": {
              "first_name":"javier",
              "last_name":"quimi",
              "email": "jquimi@pacifico.fin.ec",
              "access_token": "486a082b96c38d1ec61dae08a0583a55",
              "avatar": {
                "url": null
              },
              "national_id": "0924338577",
              "cell_phone": "3731500",
              "rewiews_count": 0,
              "rewiews_average": 0,
              "rewiews": {
                "data": []
              }
            }
          }
        },
        "agent_rewiews_count": 0,
        "agent_rewiews_average": 0,
        "agent_rewiews": []
      }
    }
  }
}
```

## Show

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/jobs/:job_id/proposals/:id`

### return example on success

Body:

```json
{
  "message": "Propuesta listadas exitosamente",
  "proposal": {
    "data": {
      Object Proposal Example
    }
  }
}
```

## Accepted

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/customers/jobs/:job_id/accepted/:id`

### return example on success

Body:

```json
{
  "message": "Propuesta aceptada exitosamente",
  "data": []
}
```