module PowerPointer
    class ContentTypes
        def initialize
            @contentTypes = []
        end
        
        def add_content_type(ct)
            if ct.respond_to?(:to_xml)
                @contentTypes << ct
            end
        end
        
        def export_xml(folder, package)
            # Export me
            export = ExportFile.new(folder, "[Content_Types].xml")
            export << "<Types xmlns=\"http://schemas.openxmlformats.org/package/2006/content-types\">"
            @contentTypes.each do |contentType|
                export << contentType.to_xml
            end
            export << "</Types>"
            package.add export
            
            # Content Types is a hardcoded file. No need to add references.
        end
    end
end