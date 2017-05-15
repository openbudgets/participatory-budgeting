class ProposalImageUploader < Shrine
  plugin :remove_invalid
  plugin :validation_helpers
  plugin :determine_mime_type

  Attacher.validate do
    validate_extension_inclusion %w[jpg jpeg png gif]
    validate_mime_type_inclusion %w[image/jpeg image/png image/gif]
    validate_max_size 8*1024*1024 # 8 MB
  end
end