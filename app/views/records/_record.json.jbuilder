json.extract! record, :id, :Title, :Label, :Format, :Country, :Released, :Genre, :Tracklist, :Condition, :Original_Price, :Selling_Price, :created_at, :updated_at
json.url record_url(record, format: :json)
