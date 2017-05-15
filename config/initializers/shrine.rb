require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permanent
}

Shrine.plugin :activerecord
Shrine.plugin :determine_mime_type
Shrine.plugin :cached_attachment_data # for forms

file_system = Shrine.storages[:cache]
file_system.clear!(older_than: Time.now - 1*24*60*60) # delete files older than 1 day