class PdfGenerator
  def initialize(public_folder_path, pdf_folder_path)
    @public_folder_path = public_folder_path
    @pdf_folder_path = pdf_folder_path
  end

  def generate(contributors)
    contributors.map.with_index(1) do |contributor, index|
      pdf_file_name = "#{contributor['login']}.pdf"
      pdf_path = "#{@pdf_folder_path}/#{pdf_file_name}"
      pdf_full_path = "#{@public_folder_path}/#{pdf_path}"

      Prawn::Document.generate(pdf_full_path) do
        text "PDF ##{index}", align: :center, size: 90, valign: :center, leading: 70
        text "The award goes to", align: :center, size: 45, valign: :center, leading: 40
        text "#{contributor['login']}", align: :center, size: 20, valign: :center
      end

      contributor['pdf_path'] = pdf_path
      
      pdf_full_path
    end
  end
end
