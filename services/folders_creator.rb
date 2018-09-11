class FoldersCreator
  def self.call(folder_path)
    folders = folder_path.split(/[\/\\]/)

    1.upto(folders.size) do |n|
      dir = folders[0..n].join('/')
      Dir.mkdir(dir) unless Dir.exist?(dir)
    end
  end
end
