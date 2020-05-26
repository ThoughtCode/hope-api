class Invoices
  def self.generate_for_job(invoice, payment, job)
    id_type = set_id_type(invoice.invoice_detail.identification_type)
    ambiente = ENV['DATIL_ENVIROMENT']
    body = '{
      "ambiente":'+ ambiente+ ',
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
        "NocNoc":"' + "Prestación de plataforma tecnológica de intermediación entre usuarios y servicios" +'"
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
        "descuento":'+ "#{number_to_currency((job.subtotal / job.promotion.discount) + job.subtotal)} "+'
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
          "descripcion": "'+ "Prestación de plataforma tecnológica de intermediación entre usuarios y servicios" +'",
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
          "descuento": '+ "#{number_to_currency((job.subtotal / job.promotion.discount) + job.subtotal)} "+'
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

    begin
      notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
        defaults channel: "#hooks",
               username: "notifier"
      end
      notifier.ping(response.body)
    rescue StandardError => e
      Rails.logger.info("Error enviando slack")
    end
  end

  def self.generate_for_penalty(invoice, payment, job)
    id_type = set_id_type(invoice.invoice_detail.identification_type)
    ambiente = ENV['DATIL_ENVIROMENT']
    body = '{
      "ambiente":'+ ambiente+ ',
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
        "NocNoc":"' + "Prestación de plataforma tecnológica de intermediación entre usuarios y servicios" +'"
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
        "descuento":'+ "#{number_to_currency((job.subtotal / job.promotion.discount) + job.subtotal)} "+'
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
          "descripcion": "'+ "Prestación de plataforma tecnológica de intermediación entre usuarios y servicios" +'",
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
          "descuento": '+ "#{number_to_currency((job.subtotal / job.promotion.discount) + job.subtotal)} "+'
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
