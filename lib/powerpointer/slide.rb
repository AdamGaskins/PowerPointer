module PowerPointer
    class Slide
        def initialize(slideId, name)
            @slideId = slideId
            @name = name
            @relationshipId = "rId_slide" + slideId.to_s
            
            @shapes = []
            
            @filename = "slide#{@slideId}.xml"
            @relationships = Relationships.new @filename
        end
        
        def add_shape name
            s = Shape.new @shapes.count + 1, name
            @shapes << s
            return s
        end
        
        def export_xml(folder, presentation, package)
            # Export me
            export = ExportFile.new(folder + "slides/", @filename)
            export << XML_HEADER
            export << "<p:sld xmlns:p=\"http://schemas.openxmlformats.org/presentationml/2006/main\" xmlns:a=\"http://schemas.openxmlformats.org/drawingml/2006/main\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\">"
                export << "<p:spTree>"
                    export << "<p:nvGrpSpPr>"
                        export << "<p:cNvPr id=\"#{PowerPointer::escape_string @slideId}\" name=\"#{PowerPointer::escape_string @name}\" />"
                        export << "<p:cNvGrpSpPr />"
                        export << "<p:nvPr />"
                    export << "</p:nvGrpSpPr>"
                    export << "<p:grpSpPr>"
                        export << "<a:xfrm>"
                            export << "<a:off x=\"0\" y=\"0\"/>"
                            export << "<a:ext cx=\"0\" cy=\"0\"/>"
                            export << "<a:chOff x=\"0\" y=\"0\"/>"
                            export << "<a:chExt cx=\"0\" cy=\"0\"/>"
                        export << "</a:xfrm>"
                    export << "</p:grpSpPr>"
                    @shapes.each do |shape|
                        export << shape.to_xml
                    end
                export << "</p:spTree>"
            export << "</p:sld>"
            package.add export
            
            # Add references to me
            presentation.get_relationships.add(@relationshipId, "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide", "slides/#{export.get_filename}")            
            c = ContentTypes::Override.new(export.get_full_path, "application/vnd.openxmlformats-officedocument.presentationml.slide+xml")
            package.add_content_type(c)
                       
            # Export relationships
            @relationships.export_xml(export.get_path, package)
        end
        
        def get_id
            @slideId
        end
        
        def get_relationship_id
            @relationshipId
        end
    end
end