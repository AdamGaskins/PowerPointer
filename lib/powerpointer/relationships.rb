module PowerPointer
    class Relationships
        def initialize(filename)
            @filename = filename
            @relationships = []
        end
        
        def add(id, type, target)
            relationship = {
                :id => id,
                :type => type,
                :target => target
            }
            @relationships << relationship
        end
        
        def get_filename
            @filename
        end
        
        def export_xml(folder, package)
            # Export me
            export = ExportFile.new(folder + "_rels/", @filename + ".rels")
            export << XML_HEADER.dup
            export << "<Relationships xmlns=\"http://schemas.openxmlformats.org/package/2006/relationships\">"
            @relationships.each do |relationship|
                export << "<Relationship Id=\"#{relationship[:id]}\" Type=\"#{relationship[:type]}\" Target=\"#{relationship[:target]}\" />"
            end
            export << "</Relationships>"
            package.add export
            
            # Add references to me
            package.add_content_type ContentTypes::Override.new(export.get_full_path, "application/vnd.openxmlformatspackage.relationships+xml")
        end
    end
end