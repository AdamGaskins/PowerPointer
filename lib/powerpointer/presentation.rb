module PowerPointer
    class Presentation
        def initialize package
            @slides = []
            @slide_masters = []
            @note_masters = []
            @handout_masters = []
            @relationship_id = "rId_presentation"

            @package = package

            @filename = "presentation.xml"

            @relationships = Relationships.new @filename

            @notes_size = [913607, 913607]
            @slide_size = [10080625, 7559675]
        end

        attr_accessor :notes_size, :slide_size, :package

        def add_slide name, layout
            s = Slide.new name, layout
            @slides << s
            return s
        end

        def add_slide_layout name, master
            s = SlideLayout.new name, master
            return s
        end

        def add_slide_master name
            s = SlideMaster.new name, self

            @slide_masters << s
            return s
        end

        def get_relationships
            @relationships
        end

        def export_xml(folder, tmpFolder)
            me_folder = folder + "ppt/"

            # Export me
            export = ExportFile.new(me_folder, @filename)
            export << XML_HEADER
            export << "<p:presentation xmlns:p=\"#{SCHEMAS[:presentation][:root]}\" xmlns:a=\"#{SCHEMAS[:drawingML]}\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\">"

                # Export slide masters
                export << "<p:sldMasterIdLst>"
                @slide_masters.each do |slide_master|
                    slide_master.export_xml(export.get_path, self, @package, tmpFolder)

                    export << "<p:sldMasterId id=\"#{slide_master.unique_id}\" r:id=\"#{slide_master.relationship_id}\" />"
                end
                export << "</p:sldMasterIdLst>"

                # Export slide list
                export << "<p:sldIdLst>"
                @slides.each do |slide|
                    slide.export_xml(export.get_path, self, @package, tmpFolder)
                    export << "<p:sldId id=\"#{slide.unique_id}\" r:id=\"#{slide.relationship_id}\" />"
                end
                export << "</p:sldIdLst>"

                # Export sizes
                export << "<p:sldSz cx=\"#{@slide_size[0]}\" cy=\"#{@slide_size[1]}\" />"
                export << "<p:notesSz cx=\"#{@notes_size[0]}\" cy=\"#{@notes_size[1]}\" />"
            export << "</p:presentation>"
            @package.add export

            # Add references to me
            @package.get_relationships.add(@relationship_id, SCHEMAS[:presentation][:relationship], export.get_full_path)
            c = ContentTypes::Override.new(export.get_full_path, SCHEMAS[:presentation][:content_type])
            @package.add_content_type(c)

            # Export relationships
            @relationships.export_xml(export.get_path, package)
        end
    end
end
