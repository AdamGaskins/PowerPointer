module PowerPointer
    class Presentation
        def initialize
            @slides = []
            @slideMasters = []
            @noteMasters = []
            @handoutMasters = []
            
            @relationships = Relationships.new "presentation.xml"
            
            @notesSize = [913607, 913607]
        end
            
        def export_xml(folder, package)
            # Export me
            export = ExportFile.new(folder + "ppt/", "presentation.xml")             
            export << XML_HEADER
            export << "<p:presentation xmlns:p=\"http://schemas.openxmlformats.org/presentationml/2006/main\">"
                export << "<p:notesSz cx=\"#{@notesSize[0]}\" cy=\"#{@notesSize[1]}\" />"
            export << "</p:presentation>"
            package.add export
            
            # Add references to me
            package.get_relationships.add("rId1", "http://purl.oclc.org/ooxml/officeDocument/relationships/officeDocument", export.get_filename)            
            c = ContentTypes::Override.new(export.get_full_path, "application/vnd.openxmlformatsofficedocument.presentationml.presentation.main+xml")
            package.add_content_type(c)
                       
            # Export relationships
            @relationships.export_xml(export.get_path, package)
        end
    end
end