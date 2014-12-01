module PowerPointer
	class Pic
		@@pic_count = 0

		def initialize path
			@@pic_count += 1
			@id = @@pic_count
			@path = path
			@filename = "img#{@id}#{File.extname path}"
			@relationship_id = "rId_image"+@id.to_s
			@x = 0
			@y = 0
			@width = 100
			@height = 100
		end

		attr_accessor :relationship_id, :path, :filename, :x, :y, :width, :height

		def to_xml
			s = ""
			s << "<p:pic>"
				s << "<p:nvPicPr>"
					s << "<p:cNvPr id=\"#{@id}\" name=\"\"/>"
					s << "<p:cNvPicPr preferRelativeResize=\"0\"/>"
					s << "<p:nvPr/>"
				s << "</p:nvPicPr>"
				s << "<p:blipFill>"
					s << "<a:blip r:embed=\"#{@relationship_id}\">"
						s << "<a:alphaModFix/>"
					s << "</a:blip>"
					s << "<a:stretch>"
						s << "<a:fillRect/>"
					s << "</a:stretch>"
				s << "</p:blipFill>"
				s << "<p:spPr>"
					s << "<a:xfrm>"
						s << "<a:off y=\"#{@y}\" x=\"#{@x}\"/>"
						s << "<a:ext cy=\"#{@height}\" cx=\"#{@width}\"/>"
					s << "</a:xfrm>"
					s << "<a:prstGeom prst=\"rect\">"
						s << "<a:avLst/>"
					s << "</a:prstGeom>"
					s << "<a:noFill/>"
					s << "<a:ln>"
						s << "<a:noFill/>"
					s << "</a:ln>"
				s << "</p:spPr>"
			s << "</p:pic>"

			return s
		end
	end
end
