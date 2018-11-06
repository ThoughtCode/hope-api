class Invoices
  def self.generate_for_job(invoice, payment, job)
    id_type = set_id_type(invoice.invoice_detail.identification_type)
    body = '{
      "ambiente":1,
      "tipo_emision":1,
      "secuencial":'+ "#{invoice.id}" +',
      "fecha_emision":"'+ Time.now.strftime('%Y-%m-%dT%H:%M:%S.%L%z') + '",
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
        "NocNoc":"' + "#{payment.description}" +'"
      },
      "totales":{
        "total_sin_impuestos":'+ "#{number_to_currency(job.subtotal)}" +',
        "impuestos":[
          {
            "base_imponible":'+ "#{number_to_currency(job.subtotal)} "+',
            "valor":'+"#{number_to_currency(job.vat)}"+',
            "codigo":"2",
            "codigo_porcentaje":"2"
          }
        ],
        "importe_total":'+"#{number_to_currency(job.total)}"+',
        "propina":0.0,
        "descuento":0.0
      },
      "comprador":{
        "email":"'+ "#{invoice.invoice_detail.email}"+'",
        "identificacion":"'+ "#{invoice.invoice_detail.identification}"+'",
        "tipo_identificacion":"'+"#{id_type}"+'",
        "razon_social":"'+"#{invoice.invoice_detail.social_reason}"+'",
        "direccion":"' + "#{invoice.invoice_detail.address }" + '",
        "telefono":"'+ "#{invoice.invoice_detail.telephone}" +'"
      },
      "items":[
        {
          "cantidad": 1,
          "precio_unitario": '+ "#{number_to_currency(job.subtotal)}" +',
          "descripcion": "'+ "Trabajo de limpieza - NocNoc" +'",
          "precio_total_sin_impuestos": '+ "#{number_to_currency(job.subtotal)} " +',
          "impuestos": [
            {
              "base_imponible":'+ "#{number_to_currency(job.subtotal)}"+',
              "valor":'+"#{number_to_currency(job.vat)}"+',
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
          "total": '+"#{number_to_currency(job.total)}"+'
        }
      ]
    }'
    Rails.logger.info(body)
    connection = Faraday.new
    response = connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-Key'] = ENV['DATIL_API_KEY']
      req.headers['X-Password'] = 'HopeServ24'
      req.url ENV['DATIL_URL'] + '/invoices/issue'
      req.body = body
    end
    Rails.logger.info(response.body)
    response = response.status
  end

  def self.generate_for_penalty(invoice, payment, job)
    id_type = set_id_type(invoice.invoice_detail.identification_type)
    body = '{
      "ambiente":1,
      "tipo_emision":1,
      "secuencial":'+ "#{invoice.id}" +',
      "fecha_emision":"'+ Time.now.strftime('%Y-%m-%dT%H:%M:%S.%L%z') + '",
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
        "NocNoc":"' + "#{payment.description}" +'"
      },
      "totales":{
        "total_sin_impuestos":'+ "#{number_to_currency(payment.amount.to_f - payment.vat.to_f)}" +',
        "impuestos":[
          {
            "base_imponible":'+ "#{number_to_currency(payment.amount.to_f - payment.vat.to_f)} "+',
            "valor":'+"#{number_to_currency(payment.vat.to_f)}"+',
            "codigo":"2",
            "codigo_porcentaje":"2"
          }
        ],
        "importe_total":'+"#{number_to_currency(payment.amount.to_f)}"+',
        "propina":0.0,
        "descuento":0.0
      },
      "comprador":{
        "email":"'+ "#{invoice.invoice_detail.email}"+'",
        "identificacion":"'+ "#{invoice.invoice_detail.identification}"+'",
        "tipo_identificacion":"'+"#{id_type}"+'",
        "razon_social":"'+"#{invoice.invoice_detail.social_reason}"+'",
        "direccion":"' + "#{invoice.invoice_detail.address }" + '",
        "telefono":"'+ "#{invoice.invoice_detail.telephone}" +'"
      },
      "items":[
        {
          "cantidad": 1,
          "precio_unitario": '+ "#{number_to_currency(payment.amount.to_f - payment.vat.to_f)}" +',
          "descripcion": "'+ "Multa de cancelación NocNoc" +'",
          "precio_total_sin_impuestos": '+ "#{number_to_currency(payment.amount.to_f - payment.vat.to_f)} " +',
          "impuestos": [
            {
              "base_imponible":'+ "#{number_to_currency(payment.amount.to_f - payment.vat.to_f)}"+',
              "valor":'+"#{number_to_currency(payment.vat.to_f)}"+',
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
          "total": '+"#{number_to_currency(payment.amount.to_f)}"+'
        }
      ]
    }'
    Rails.logger.info(body)
    connection = Faraday.new
    response = connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-Key'] = ENV['DATIL_API_KEY']
      req.headers['X-Password'] = 'HopeServ24'
      req.url ENV['DATIL_URL'] + '/invoices/issue'
      req.body = body
    end
    Rails.logger.info(response.body)
    response = response.status
  end
end

def number_to_currency(number)
  ActiveSupport::NumberHelper.number_to_currency(number, precision: 2).tr('$', '')
end

def set_id_type(id)
  # Datil.co information (07 - Consumidor final, 05 - cedula, 04 - RUC)
  return '07' if id == 'consumidor_final'
  return '05' if id == 'cedula'
  return '04' if id == 'ruc'
end
