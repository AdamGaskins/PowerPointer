module PowerPointer
    class Presentation
        def initialize
            @slides = []
            @slideMasters = []
            @noteMasters = []
            @handoutMasters = []
            @relationshipId = "rId_presentation"
            
            @filename = "presentation.xml"
            
            @relationships = Relationships.new @filename
            
            @notesSize = [913607, 913607]
            @slideSize = [10080625, 7559675]
        end
            
        def add_slide
            s = Slide.new(@slides.count + 1)
            @slides << s
        end
            
        def get_relationships
            @relationships
        end
            
        def export_xml(folder, package)
            me_folder = folder + "ppt/"
        
            # Export me
            export = ExportFile.new(me_folder, @filename)             
            export << XML_HEADER
            export << "<p:presentation xmlns:p=\"http://schemas.openxmlformats.org/presentationml/2006/main\"  xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\">"
            
                # Export slide masters
                export << "<p:sldMasterIdLst>"
                export << "</p:sldMasterIdLst>"
                
                # Export slide list
                export << "<p:sldIdLst>"
                @slides.each do |slide|
                    slide.export_xml(export.get_path, self, package)
                    export << "<p:sldId id=\"#{slide.get_id}\" r:id=\"#{slide.get_relationship_id}\" />"
                end
                export << "</p:sldIdLst>"
                
                # Export sizes
                export << "<p:sldSz cx=\"#{@slideSize[0]}\" cy=\"#{@slideSize[1]}\" />"
                export << "<p:notesSz cx=\"#{@notesSize[0]}\" cy=\"#{@notesSize[1]}\" />"
            export << "</p:presentation>"
            package.add export
            
            # Add references to me
            package.get_relationships.add(@relationshipId, "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument", export.get_full_path)            
            c = ContentTypes::Override.new(export.get_full_path, "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml")
            package.add_content_type(c)
                       
            # Export relationships
            @relationships.export_xml(export.get_path, package)
        end
    end
end