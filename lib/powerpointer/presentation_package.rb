require 'fileutils'

module PowerPointer
    class PresentationPackage
        def initialize
            @presentation = Presentation.new
            @contentTypes = ContentTypes.new
            @relationships = Relationships.new("")
            
            @exportFiles = []
            
            @verbose = false
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
               
        def export_xml(tmp_folder = "tmpppt_root")
            rootFolder = ""

            vputs ""
            vputs "Preparing..."
            vputs ""
            
            # Prepare presentation
            @presentation.export_xml(rootFolder, self)
            
            # Prepare content types
            @contentTypes.export_xml(rootFolder, self)
            
            # Prepare relationships            
            @relationships.export_xml(rootFolder, self)
                      
            # Remove directory if it exists
            FileUtils::remove_dir(tmp_folder, true)
                      
            # Do the export
            @exportFiles.each do |file|
                # Debug
                vputs "Exporting #{file.get_full_path}"
                
                # Create the path if it doesn't exist
                path = "#{tmp_folder}/#{file.get_path}"
                FileUtils::mkdir_p path
                
                # Write the file
                File.open("#{path}/#{file.get_filename}", "w") do |f|
                    f << file.get_content
                end
            end
            vputs ""
            vputs "Completed!"
            vputs ""
        end
        
        def add_content_type(ct)
            @contentTypes.add_content_type ct
        end        
        
        private
        
        def vputs s
            if verbose
                puts s
            end
        end
    end
end