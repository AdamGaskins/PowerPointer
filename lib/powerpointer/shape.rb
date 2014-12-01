module PowerPointer
    class Shape
        @@shape_count = 0
        @@next_placeholder_id = 1
        @@placeholders = {}
        def initialize name
            initialize name, name
        end

        def initialize name, friendly_idx
            @@shape_count++

            @id = @@shape_count
            @name = name
            @type = "body"
            @x = -1
            @y = -1
            @width = -1
            @height = -1

            set_placeholder (friendly_idx)

            @use_size = false

            @is_text_box = false
            @paragraphs = []
            add_paragraph()
        end

        def add_paragraph
            @is_text_box = true
            @current_paragraph = PowerPointer::Paragraph.new
            @paragraphs << @current_paragraph
        end

        def get_paragraph
            @is_text_box = true
            @current_paragraph
        end

        def placeholder
            @placeholder
        end

        def set_placeholder pl
            if !@@placeholders.has_key? pl.to_s
                @@placeholders[pl] = @@next_placeholder_id
                @@next_placeholder_id += 1
            end
            @placeholder = pl
        end

        def to_xml type
            nvSpPr = "nvSpPr"

            if type == :slide
                nvSpPr = "nvSpPr"
            elsif type == :slide_layout
                nvSpPr = "nvSpPr"
            end

            s = ""
            s << "<p:sp>"
                s << "<p:#{nvSpPr}>"
                    s << "<p:cNvPr id=\"#{PowerPointer::escape_string @id}\" name=\"#{PowerPointer::escape_string @name}\" />"
                    s << "<p:cNvSpPr txBox=\"#{@is_text_box ? 1 : 0}\" />"
                    s << "<p:nvPr>"
                        s << "<p:ph type=\"#{PowerPointer::escape_string @type}\" idx=\"#{PowerPointer::escape_string @@placeholders[@placeholder]}\" />"
                    s << "</p:nvPr>"
                s << "</p:#{nvSpPr}>"
                s << "<p:spPr>"
                if @use_size
                    s << "<a:xfrm>"
                        s << "<a:off x=\"#{PowerPointer::escape_string @x}\" y=\"#{PowerPointer::escape_string @y}\" />"
                        s << "<a:ext cx=\"#{PowerPointer::escape_string @width}\" cy=\"#{PowerPointer::escape_string @height}\" />"
                    s << "</a:xfrm>"
                end
                    s << "<a:prstGeom prst=\"rect\">"
                        s << "<a:avLst />"
                    s << "</a:prstGeom>"
                s << "</p:spPr>"

            if @is_text_box
                s << "<p:txBody>"
                    s << "<a:bodyPr />"
                    @paragraphs.each do |para|
                        s << para.to_xml
                    end
#                    s << "<a:p>"
#                        @text_runs.each do |text|
#                            s << "<a:r>"
#                                s << "<a:rPr #{text[:styles]} />"
#                                s << "<a:t>#{PowerPointer::escape_tag text[:text]}</a:t>"
#                            s << "</a:r>"
#                        end
#                    s << "</a:p>"
                s << "</p:txBody>"
            end

            s << "</p:sp>"

            return s
        end

        attr_accessor :x, :y, :width, :height, :is_text_box, :type, :use_size
    end
end
