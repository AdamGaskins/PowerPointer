module PowerPointer
    class Shape
        @@shape_count = 0
        def initialize name
            @@shape_count++

            @id = @@shape_count
            @name = name
            @placeholder = name
            @type = "body"
            @x = -1
            @y = -1
            @width = -1
            @height = -1

            @use_size = false

            @is_text_box = false
            @text = ""
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
                        s << "<p:ph type=\"#{PowerPointer::escape_string @type}\" idx=\"#{PowerPointer::escape_string @placeholder}\" />"
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
                    s << "<a:p>"
                        s << "<a:r>"
                            s << "<a:t>#{PowerPointer::escape_tag @text}</a:t>"
                        s << "</a:r>"
                    s << "</a:p>"
                s << "</p:txBody>"
            end

            s << "</p:sp>"

            return s
        end

        def set_text text
            @is_text_box = true
            @text = text
        end

        attr_accessor :x, :y, :width, :height, :is_text_box, :placeholder, :type, :use_size
    end
end
