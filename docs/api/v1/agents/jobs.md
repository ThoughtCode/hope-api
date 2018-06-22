# Jobs API

Table of Contents:

- [Object Example](#object-example)
- [Index](#index)
- [Accepted](#accepted)
- [Completed](#completed)
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
        "status": "pending", /* pending accepted cancelled expired completed */
        "frequency": 3, /* 0 = one_time, 1 = weekly, 2 = fortnightly, 3 = monthly */        
        "property": {
          "id":3,
          "name":"Working Up",
          "neightborhood_id":1,
          "p_street":"San Ignacio",
          "number":"123456",
          "s_street":"González Suarez",
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

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/jobs?date_from=<datetime>&date_to=<datetime>&min_price=<number>&max_price=<number>&frequency=<number[0|1|2|3]>&current_page=<integer>`

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
        "status": "pending", /* pending accepted cancelled expired completed */
        "frequency": 3, /* 0 = one_time, 1 = weekly, 2 = fortnightly, 3 = monthly */  
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

# Accepted

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/jobs/accepted?date_from=<datetime>&date_to=<datetime>&min_price=<number>&max_price=<number>&frequency=<number[0|1|2|3]>&current_page=<integer>`

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
        "status": "accepted", /* pending accepted cancelled expired completed */
        "frequency": 2, /* 0 = one_time, 1 = weekly, 2 = fortnightly, 3 = monthly */
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

# Completed

Method: `GET`

Header: `[HTTP_AUTHORIZATION]` = `Token token=XXXXXXXXXXXXXX`

URI: `/api/v1/agents/jobs/completed?date_from=<datetime>&date_to=<datetime>&min_price=<number>&max_price=<number>&frequency=<number[0|1|2|3]>&current_page=<integer>`

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
        "status": "completed", /* pending accepted cancelled expired completed */
        "frequency": 2, /* 0 = one_time, 1 = weekly, 2 = fortnightly, 3 = monthly */
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
        "status": "pending", /* pending accepted cancelled expired completed */
        "frequency": 3, /* 0 = one_time, 1 = weekly, 2 = fortnightly, 3 = monthly */  
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
