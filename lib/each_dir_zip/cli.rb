require "thor"

module EachDirZip
  class Cli < Thor
    package_name "dir_zip"
    default_command :compress

    desc "compress TARGET_DIR", "Each under target_dir compress directories"
    def compress(path = Dir.pwd)
      dir_name_list = Dir::entries(path).reject { |p| p == "." || p == ".." }.select { |p| File.directory?("#{path}/#{p}") }

      dir_name_list.each do |dir_name|
        target_dir = "#{path}/#{dir_name}"
        system("zip -r9 '#{target_dir}.zip' '#{target_dir}'")
        FileUtils.remove_dir(target_dir)
      end
    end
  end
end
