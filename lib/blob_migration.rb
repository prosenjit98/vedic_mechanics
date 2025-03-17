source_service = ActiveStorage::Blob.services.fetch(:service_a)
destination_service = ActiveStorage::Blob.services.fetch(:service_b)
# :service_a/b above should be top-level keys from `config/storage.yml`

ActiveStorage::Blob.where(service_name: source_service.name).find_each do |blob|
  key = blob.key

  raise "I can't find blob #{blob.id} (#{key})" unless source_service.exist?(key)

  unless destination_service.exist?(key)
    source_service.open(blob.key, checksum: blob.checksum) do |file|
      destination_service.upload(blob.key, file, checksum: blob.checksum)
    end
  end
  blob.update_columns(service_name: destination_service.name)
end