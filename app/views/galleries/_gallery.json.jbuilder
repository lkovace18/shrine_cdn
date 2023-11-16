json.extract! gallery, :id, :name, :image_data, :created_at, :updated_at
json.url gallery_url(gallery, format: :json)
