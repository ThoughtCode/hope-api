# Payments Controller API

Table of Contents:

- [List Cards](#list_cards)
- [Add_card](#add_card)
- [Delete_card](#delete_card)
- [Payments Received](#received)
- [Payments Update](#update)


## List Card

Method: `Get`

URI: `/api/v1/customers/credit_cards`

Header: `[HTTP_AUTHORIZATION]` = `Token XXXXXXXXXXXXXX`

body:
```json
{
    "message": "Tarjetas Listadas",
    "payment": {
        "data": [
            {
                "id": "12",
                "type": "payment",
                "attributes": {
                    "holder_name": "Henry Remache",
                    "card_type": "vi",
                    "number": "1111",
                    "token": "9209405777683805561",
                    "status": "valid",
                    "expiry_month": "1",
                    "expiry_year": "2019"
                }
            }
        ]
    }
}
```

## Add Card

Method: `POST`

URI: `/api/v1/customers/add_card`

Header: `[HTTP_AUTHORIZATION]` = `Token XXXXXXXXXXXXXX`

body:
```json
{  
   "payment":{  
      "holder_name":"Henry Remache", 
      "card_type":"vi",
      "number":"1111",
      "token":"9209405777683805561",
      "status":"valid", 
      "expiry_month":"1", 
      "expiry_year":"2019"
   }
}
```


### Return example on success, 200

```json
{
    "message": "Tarjeta creada exitosamente",
    "payment": {
        "data": {
            "id": "15",
            "type": "payment",
            "attributes": {
                "holder_name": "Henry Remache",
                "card_type": "vi",
                "number": "1111",
                "token": "9209405777683805561",
                "status": "valid",
                "expiry_month": "1",
                "expiry_year": "2019"
            }
        }
    }
}
```


## Delete Card

Method: `DELETE`

URI: `/api/v1/customers/delete_card/:id`

Header: `[HTTP_AUTHORIZATION]` = `Token XXXXXXXXXXXXXX`

On Success



### Return example on success, 200

```json
{
    "message": "Tarjeta borrada exitosamente",
    "payment": {
        "data": {
            "id": "14",
            "type": "payment",
            "attributes": {
                "holder_name": "Henry Remache",
                "card_type": "vi",
                "number": "1111",
                "token": "9209405777683805561",
                "status": "valid",
                "expiry_month": "1",
                "expiry_year": "2019"
            }
        }
    }
}
```

### Return example on failure, 404


body:
```json
{
    "message": {
        "base": [
            "Error al borrar tarjeta"
        ]
    },
    "data": []
}
```


### Return example on success, 200

```json
{
    "message": "Tarjeta creada exitosamente",
    "payment": {
        "data": {
            "id": "2",
            "type": "payment",
            "attributes": {
                "holder_name": "Henry Remache",
                "card_type": "vi",
                "number": "1111",
                "token": "9209405777683805561",
                "status": "valid",
                "expiry_month": "1",
                "expiry_year": "2019"
            }
        }
    }
}

```

### Return example on failure, 401

```
  Unauthorized

```


## Received

Method: `POST`

URI: `/api/v1/customers/payments_received`

### Return example on success, 200

```
```

## Update

Method: `POST`

URI: `/api/v1/customers/payments_update`

### Return example on success, 200

```
```