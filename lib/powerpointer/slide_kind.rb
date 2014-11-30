module PowerPointer
    class SlideKind
        def _initialize(id, unique_id, item_name, rootElement, name, schema_id)
            @root = rootElement
            @schema_id = schema_id

            @id = id
            @unique_id = unique_id
            @name = name
            @item_name = item_name
            @folder_name = "#{item_name}s"
            @relationship_id = "rId_#{item_name}#{@id.to_s}"

            @shapes = []

            @file_name = "#{item_name}#{@id}.xml"
            @relationships = Relationships.new @file_name

            @presentation_relationship = true

            if item_name == "slide"
                @n = "cN"
            else
                @n = "n"
            end
        end

        def custom_xml
            # This function needs to be overridden in Slide/SlideLayout/SlideMaster
            return ""
        end

        def add_shape name
            s = Shape.new name
            @shapes << s
            return s
        end

        def export_xml(folder, presentation, package)
            # Export me
            export = ExportFile.new(folder + "#{@folder_name}/", @file_name)
            export << XML_HEADER
            export << "<p:#{@root} xmlns:p=\"#{SCHEMAS[@schema_id][:root]}\" xmlns:a=\"#{SCHEMAS[:drawingML]}\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\">"
                export << "<p:cSld name=\"#{PowerPointer::escape_string @name}\">"
                    export << "<p:spTree>"
                        custom_xml("spTree", export, folder, presentation, package)
                        export << "<p:nvGrpSpPr>"
                            export << "<p:cNvPr id=\"#{PowerPointer::escape_string @id}\" name=\"#{PowerPointer::escape_string @name}\" />"
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
                            export << shape.to_xml(@schema_id)
                        end
                    export << "</p:spTree>"
                export << "</p:cSld>"
                custom_xml(@root, export, folder, presentation, package)
            export << "</p:#{@root}>"
            package.add export

            # Add references to me
            if @presentation_relationship
                presentation.get_relationships.add(@relationship_id, SCHEMAS[@schema_id][:relationship], "#{@folder_name}/#{export.get_filename}")
            end
            c = ContentTypes::Override.new(export.get_full_path, SCHEMAS[@schema_id][:content_type])
            package.add_content_type(c)

            # Export relationships
            @relationships.export_xml(export.get_path, package)
        end

        attr_accessor :file_name, :id, :unique_id, :relationship_id
    end
end
