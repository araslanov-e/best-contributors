class ZipGenerator
  def initialize(public_folder_path, zip_folder_path)
    @public_folder_path = public_folder_path
    @zip_folder_path = zip_folder_path
  end

  def generate(files)
    return if files.length.zero?

    zip_file_name = "best_contributors.zip"
    zip_path = "#{@zip_folder_path}/#{zip_file_name}"
    zip_full_path = "#{@public_folder_path}/#{zip_path}"

    File.delete(zip_full_path) if File.exist?(zip_full_path)

    Zip::File.open(zip_full_path, Zip::File::CREATE) do |zipfile|
      files.each do |file|
        zipfile.add(File.basename(file), file)
      end
    end

    {
      path: zip_path,
      files_counts: files.length
    }
  end
end
