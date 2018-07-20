# Jobs API

Table of Contents:

- [Object Example](#object-example)
- [Index](#index)
- [Accepted](#accepted)
- [Completed](#completed)
- [Show](#show)

## Object example

### Job Object Example

```json
{
  "id": "5b4e4262e0cb200004f52dba",
  "type": "job",
  "attributes": {
    "property_id": 23,
    "started_at": "2018-07-19T19:23:52.542Z",
    "finished_at": "2018-07-19T23:23:52.542Z",
    "duration": 4,
    "total": 145.6,
    "status": "pending",
    "frequency": "fortnightly",
    "property": {
    },
    "agent": null, // If not assigned, Object agent example if assigned
    "details": "",
    "agent_rewiews_count": null,
    "agent_rewiews_average": null,
    "agent_rewiews": null,
    "job_details": [
      Array of job_details example
    ],
    "customer": {
      Object Customer Exapmle
    },
    "proposals": {
      "data": [
        Array of Object proposal example
      ]
    },
    "can_cancel": false,
  }
}
```

### Job Details Example

```json
{
  "id": 191,
  "service_id": 1,
  "value": 1,
  "time": 2,
  "price_total": 100,
  "service": {
    "id": 1,
    "service_type_id": 1,
    "type_service": "base",
    "name": "Limpieza de Casa",
    "quantity": false,
    "time": 2,
    "price": 50,
    "icon": "ICON SVG"
  }
},
```

### Property Example

```json
{
  "data": {
    "id": "5b4e0ee787fee200048091fe",
    "type": "property",
    "attributes": {
      "id": 23,
      "name": "Working Up",
      "p_street": "San ignacio",
      "number": "n3028",
      "s_street": "Gonzalo Suarez",
      "additional_reference": "Edificio working up",
      "phone": "12345678901",
      "neightborhood_id": 1,
      "neightborhood": "Monteserrin",
      "city_id": 1,
      "city": "Quito",
      "customer": {
        Object Customer Exapmle
      }
    }
  }
```

### Customer Example

```json
{
  "data": {
    "id": "69",
    "type": "customer",
    "attributes": {
      "first_name": "Rai",
      "last_name": "Romero",
      "email": "rainieromadrid@hotmail.com",
      "access_token": "112546e587778492995e48d56fbe0294",
      "avatar": {
        "url": "https://noc-noc.s3.amazonaws.com/uploads/customer/avatar/69/profilepic.jpeg"
      },
      "national_id": null,
      "cell_phone": null,
      "rewiews_count": 0,
      "rewiews_average": 0,
      "rewiews": []
    }
  }
}
```

### Object Proposal example

```json
{
  "id": "5b4e5d768f3bd20004c690d2",
  "type": "proposal",
  "attributes": {
    "id": 54,
    "job": {
      "id": 115,
      "property_id": 23,
      "duration": 4,
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
        Object Agent Example
      }
    },
    "agent_rewiews_count": 0,
    "agent_rewiews_average": 0,
    "agent_rewiews": []
  }
}
```

### Object Agent example

```json
{
  "data": {
    "id": "29",
    "type": "agent",
    "attributes": {
      "first_name": "javier",
      "last_name": "quimi",
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
```

## Index

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/jobs?date_from=<datetime>&date_to=<datetime>&min_price=<number>&max_price=<number>&frequency=<number[0|1|2|3]>&current_page=<integer>`

### Return example on success, 200

```json
{
  "message": "Trabajos listados exitosamente",
  "job": {
    "data": [
      Array of Object Job Example
    ]
  }
}

```

## Accepted

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/jobs/accepted?date_from=<datetime>&date_to=<datetime>&min_price=<number>&max_price=<number>&frequency=<number[0|1|2|3]>&current_page=<integer>`

### Return example on success for accepted, 200

```json
{
  "message": "Trabajos listados exitosamente",
  "job": {
    "data": [
      Array of object job example
    ]
  }
}

```

## Completed

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/jobs/completed?date_from=<datetime>&date_to=<datetime>&min_price=<number>&max_price=<number>&frequency=<number[0|1|2|3]>&current_page=<integer>`

### Return example on success for completed, 200

```json
{
  "message": "Trabajos listados exitosamente",
  "job": {
    "data": [
      Array of object job example
    ]
  }
}

```

## Show

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/jobs/:id`

### return example on success

Body:

```json
{
  "message": "Trabajo econtrado existosamente.",
  "job": {
    "data": {
      Object job example
    }
  }
}
```

## Can Apply

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/jobs/:job_id/can_apply`

### Return example on success for completed, 200

```json
{
  "message": "El trabajo fue encontrado exitosamente.",
  "can_apply": true
}

```

## Can Review

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `api/v1/agents/jobs/:job_id/can_review`

### Return example on success for completed, 200

```json
{
  "message": "No puedes realizar esta calificacion en este momento",
  "can_review": false
}

```