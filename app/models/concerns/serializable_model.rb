module SerializableModel
  extend ActiveSupport::Concern

  def serialize_row!(columns)
    columns.push(:id)

    row = build_row(columns)

    {
      "data": {
        "id": row[:id].to_s,
        "type": self.class.name.downcase,
        "attributes": row
      }
    }
  end

  def build_row(columns)
    row = {}
    columns.each do |c|
      if c.is_a?(Hash)
        sub = eval("self.#{c.keys[0].to_s}")
        row.merge!(c.keys[0] => JSON.parse(sub.to_json, symbolize_names: true).slice(*c[c.keys[0]]))
      else
        row[c] = eval("self.#{c}")
      end
    end
    row
  end
end
