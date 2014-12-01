require 'fileutils'
require 'tmpdir'

module PowerPointer
    class PresentationPackage
        def initialize
            @presentation = Presentation.new self
            @contentTypes = ContentTypes.new
            @relationships = Relationships.new("")

            @contentTypes.add_content_type PowerPointer::ContentTypes::Default.new( "png", "image/png")
            @contentTypes.add_content_type PowerPointer::ContentTypes::Default.new( "jpeg", "image/jpeg")
            @contentTypes.add_content_type PowerPointer::ContentTypes::Default.new( "jpg", "image/jpeg")

            @exportFiles = []

            @verbose = false
        end

        def export_xml output
            rootFolder = ""

            vputs ""
            vputs "Preparing..."
            vputs ""

            # Create tmp directory
            Dir.mktmpdir do |tmp_folder|

                # 1. Prepare presentation (Adds relationships and content types)
                @presentation.export_xml(rootFolder, tmp_folder)

                # 2. Prepare relationships (Adds content types)
                @relationships.export_xml(rootFolder, self)

                # 3. Prepare content types
                @contentTypes.export_xml(rootFolder, self)

                vputs "Created temporary directory: #{tmp_folder}"

                # Do the export
                @exportFiles.each do |file|
                    vputs "Exporting #{file.get_full_path}"

                    # Create the path if it doesn't exist
                    path = "#{tmp_folder}/#{file.get_path}"
                    FileUtils::mkdir_p path

                    # Write the file
                    File.open("#{path}/#{file.get_filename}", "wb") do |f|
                        f << file.get_content
                    end
                end

                vputs ""
                vputs "Export complete."
                vputs ""
                vputs "Zipping..."
                vputs ""

                # Delete zip file if it exists
                if File::exists? output
                    File::delete output
                end

                # Init zip file
                Zip::File.open(output, Zip::File::CREATE) do |zip|
                    # Add each file to zip
                    @exportFiles.each do |file|
                        zip.add(file.get_full_path, File.join(tmp_folder, file.get_full_path))
                    end
                end

                vputs "Zipping complete."
                vputs ""

                # tmp directory is erased
            end
        end

        def add_content_type(ct)
            @contentTypes.add_content_type ct
        end

        def verbose=(verbose)
            @verbose = verbose
        end

        def verbose
            @verbose
        end

        def get_relationships
            @relationships
        end

        def get_presentation
            @presentation
        end

        def add file
            @exportFiles << file
        end

        private

        def vputs s
            if verbose
                puts s
            end
        end
    end
end
