class Invoices
  def self.generate_for_job(invoice, payment, job, invoice_details)
    byebug

    body = '{
      "ambiente":1,
      "tipo_emision":1,
      "secuencial":"#{invoice.id}",
      "fecha_emision":"' + Time.now.strftime('%Y-%m-%dT%H:%M:%S.%L%z') + '",
      "emisor":{
        "ruc":"1792851300001",
        "obligado_contabilidad":true,
        "contribuyente_especial":"",
        "nombre_comercial":"NOC NOC",
        "razon_social":"Hopeserv Cia.Ltda.",
        "direccion":"Quito, Av Bosmediano E4-125 y Gonzalez Suarez, Edificio Biarritz 307",
        "establecimiento":{
          "punto_emision":"002",
          "codigo":"001",
          "direccion":"Quito, Av Bosmediano E4-125 y Gonzalez Suarez, Edificio Biarritz 307"
        }
      },
      "moneda":"USD",
      "informacion_adicional":{
        "NocNoc":"#{payment.description}"
      },
      "totales":{
        "total_sin_impuestos":#{job.subtotal.to_s},
        "impuestos":[
          {
            "base_imponible":#{job.subtotal.to_s},
            "valor":#{job.vat.to_s},
            "codigo":"2",
            "codigo_porcentaje":"2"
          }
        ],
        "importe_total":#{job.total.to_s},
        "propina":0.0,
        "descuento":0.0
      },
      "comprador":{
        "email":"#{invoice_details.email}",
        "identificacion":"#{invoice_details.identification}",
        "tipo_identificacion":"#{invoice_details.identification_type}",
        "razon_social":"#{invoice_details.social_reason}",
        "direccion":"#{invoice_details.address}",
        "telefono":"#{invoice_details.telephone}"
      },
      "items":[
        {
          "cantidad": 1,
          "precio_unitario": #{job.subtotal.to_s},
          "descripcion": "#{payment.description}",
          "precio_total_sin_impuestos": #{job.subtotal.to_s},
          "impuestos": [
            {
              "base_imponible":#{job.subtotal.to_s},
              "valor":#{job.vat.to_s},
              "tarifa":12.0,
              "codigo":"2",
              "codigo_porcentaje":"2"
            }
          ],
          "descuento": 0.0
        }
      ],
      "pagos": [
        {
          "medio": "tarjeta_credito",
          "total": #{job.total.to_s}
        }
      ]
    }'


    Rails.logger.info(body)
    connection = Faraday.new
    byebug
    response = connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-Key'] = ENV['DATIL_API_KEY']
      req.headers['X-Password'] = 'HopeServ24'
      req.url ENV['DATIL_URL'] + '/invoices/issue'
      req.body = body
    end
    byebug
    Rails.logger.info(response.body)
    response = response.status


  end
end


# curl -v https://link.datil.co/invoices/issue \
# -H "Content-Type: application/json" \
# -H "X-Key: <API-key>" \
# -H "X-Password: <clave-certificado-firma>" \
# -d 
# '{
#   "ambiente":1,
#   "tipo_emision":1,
#   "secuencial":148,
#   "fecha_emision":"2015-02-28T11:28:56.782Z",
#   "emisor":{
#     "ruc":"1792851300001",
#     "obligado_contabilidad":true,
#     "contribuyente_especial":"",
#     "nombre_comercial":"NOC NOC",
#     "razon_social":"Hopeserv Cia.Ltda.",
#     "direccion":"Quito, Av Bosmediano E4-125 y Gonzalez Suarez, Edificio Biarritz 307",
#     "establecimiento":{
#       "punto_emision":"002",
#       "codigo":"001",
#       "direccion":"Quito, Av Bosmediano E4-125 y Gonzalez Suarez, Edificio Biarritz 307"
#     }
#   },
#   "moneda":"USD",
#   "informacion_adicional":{
#     "NocNoc":"Trabajo de Limpieza"
#   },
#   "totales":{
#     "total_sin_impuestos":4359.54,
#     "impuestos":[
#       {
#         "base_imponible":0.0,
#         "valor":0.0,
#         "codigo":"2",
#         "codigo_porcentaje":"0"
#       },
#       {
#         "base_imponible":4359.54,
#         "valor":523.14,
#         "codigo":"2",
#         "codigo_porcentaje":"2"
#       }
#     ],
#     "importe_total":4882.68,
#     "propina":0.0,
#     "descuento":0.0
#   },
#   "comprador":{
#     "email":"henry2992@hotmail.com",
#     "identificacion":"0604354050",
#     "tipo_identificacion":"05",
#     "razon_social":"Henry Remache",
#     "direccion":"Calle única Numero 987",
#     "telefono":"046029400"
#   },
#   "items":[
#     {
#       "cantidad":622.0,
#       "codigo_principal": "ZNC",
#       "codigo_auxiliar": "050",
#       "precio_unitario": 7.01,
#       "descripcion": "Zanahoria granel  50 Kg.",
#       "precio_total_sin_impuestos": 4360.22,
#       "impuestos": [
#         {
#           "base_imponible":4359.54,
#           "valor":523.14,
#           "tarifa":12.0,
#           "codigo":"2",
#           "codigo_porcentaje":"2"
#         }
#       ],
#       "detalles_adicionales": {
#         "Peso":"5000.0000"
#       },
#       "descuento": 0.0,
#       "unidad_medida": "Kilos"
#     }
#   ],
#   "valor_retenido_iva": 70.40,
#   "valor_retenido_renta": 29.60,
#   "credito": {
#     "fecha_vencimiento": "2015-03-28",
#     "monto": 34.21
#   },
#   "pagos": [
#     {
#       "medio": "tarjeta_credito",
#       "total": 4882.68
#     }
#   ]
# }'