namespace :pictures do
  desc 'Import pictures'
  task :import => :environment do
    path = File.join File.expand_path('../../../public', __FILE__), ENV['DIR']

    if File.directory? path
      Dir["#{path}/**/**"].each do |file|
        if File.file? file
          sku = File.basename(File.dirname(file))
          album = Album.where(sku: sku).first
          album ||= Album.new sku: sku, title: sku
          if album.new_record?
            album.cover = File.open(file)
            album.save!
          end
          album.pictures.create! file: File.open(file)
        end
      end

    else
      raise 'No such directory.'
    end
  end
end