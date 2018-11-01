class ZipGenerator
  def self.call(file_name, files, root_path, files_storage_path)
    return if files.length.zero?

    file_name = "#{file_name}.zip"
    file_path = "#{files_storage_path}/#{file_name}"
    full_file_path = "#{root_path}/#{file_path}"

    File.delete(full_file_path) if File.exist?(full_file_path)

    Zip::File.open(full_file_path, Zip::File::CREATE) do |zipfile|
      files.each do |file|
        zipfile.add(File.basename(file), file)
      end
    end

    {
      path: file_path,
      files_counts: files.length
    }
  end
end
