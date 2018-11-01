class PdfGenerator
  def self.call(contributors, root_path, files_storage_path)
    result = {}

    contributors.each.with_index(1) do |contributor, index|
      file_name = "#{contributor['login']}.pdf"
      file_path = "#{files_storage_path}/#{file_name}"
      full_file_path = "#{root_path}/#{file_path}"

      Prawn::Document.generate(full_file_path) do
        text "PDF ##{index}", align: :center, size: 90, valign: :center, leading: 70
        text "The award goes to", align: :center, size: 45, valign: :center, leading: 40
        text "#{contributor['login']}", align: :center, size: 20, valign: :center
      end

      result[contributor['login']] = {
        file_path: file_path,
        full_file_path: full_file_path
      }
    end

    result
  end
end
