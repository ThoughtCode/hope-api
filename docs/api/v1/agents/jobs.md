# Jobs API

Table of Contents:

- [Show](#show)

# Show

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/jobs/:id`

## return example on success

Body:

```json
{
  "message": "Trabajo econtrado existosamente.",
  "job": {
    "data": {
      "id": "XXXXXXXXXXXXXXXXXXXXXX",
      "type": "job",
      "attributes": {
        "id": XX,
        "property_id": X,
        "started_at": "2018-05-06T23:54:21.000Z",
        "finished_at": "2018-05-07T04:54:21.000Z",
        "duration": X,
        "total": XX,
        "status": "pending", // ["pending", "accepted", "refused", "expired"]
        "job_details": [
          {
            "id": XX,
            "service_id": X,
            "value": X,
            "time": X,
            "price_total": XX,
            "service": {
              "id": X,
              "service_type_id": X,
              "type_service": X,
              "name": "XXXXXXXXXXXXXXXX",
              "quantity": false,
              "time": X,
              "price": XX
            }
          },
        ],
      }
    }
  }
}
```
