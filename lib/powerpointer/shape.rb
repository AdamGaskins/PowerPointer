module PowerPointer
    class Shape
        def initialize (id, name)
            @id = id
            @name = name
            @x = 0
            @y = 0
            @width = 0
            @height = 0

            @is_text_box = false
            @text = ""
        end

        def to_xml
            s = ""
            s << "<p:sp>"
                s << "<p:nvSpPr>"
                    s << "<p:cNvPr id=\"#{PowerPointer::escape_string @id}\" name=\"#{PowerPointer::escape_string @name}\" />"
                    s << "<p:NvSpPr txBox=\"#{@is_text_box ? 1 : 0}\" />"
                    s << "<p:nvPr />"
                s << "</p:nvSpPr>"
                s << "<p:spPr>"
                    s << "<a:xfrm>"
                        s << "<a:off x=\"#{@x}\" y=\"#{@y}\" />"
                        s << "<a:ext cx=\"#{@width}\" cy=\"#{@height}\" />"
                    s << "</a:xfrm>"
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
                        s << "<a:r>"                        
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

        attr_accessor :x, :y, :width, :height, :is_text_box
    end
end
