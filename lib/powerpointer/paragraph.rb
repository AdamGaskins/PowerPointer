module PowerPointer
	class Paragraph
		def initialize
			@color = "000000"
			@font_family = "Calibri"
			@font_size = 1200
			@align = "l"
			@text_runs = []
		end

		attr_accessor :font_family, :font_size, :color

		def add_run text
			add_run_hash({text: text})
		end

		def add_break
				@text_runs << {
					type: :break
				}
		end

		def add_run_hash text
			text_item = {
				b: false,
				i: false,
				u: false,
				font_size: @font_size,
				color: @color,
				font_family: @font_family,
				text: "",
				type: :paragraph
			}

			text.each do |key, value|
				text_item[key] = value
			end

			@text_runs << text_item
		end

		def align_left
			@align = "l"
		end

		def align_right
			@align = "r"
		end

		def align_center
			@align = "ctr"
		end

		def align_justified
			@align = "just"
		end

		def rPr(s, style, root="rPr")
			s << "<a:#{root} "
			s << "sz=\"#{PowerPointer::escape_string style[:font_size]}\" "
			s << "b=\"1\" " if style[:b]
			s << "i=\"1\" " if style[:i]
			s << "u=\"sng\" " if style[:u]
			#s << "algn=\"#{PowerPointer::escape_string style[:align]}\" " if style.has_key?(:align)
			s << ">"
				s << "<a:solidFill>"
					s << "<a:srgbClr val=\"#{PowerPointer::escape_string style[:color]}\"/>"
				s << "</a:solidFill>"
				s << "<a:latin typeface=\"#{PowerPointer::escape_string style[:font_family]}\"/>"
			s << "</a:#{root}>"
		end

		def to_xml
			s = ""
			s << "<a:p>"
				#rPr(s, {}, "pPr")
				@text_runs.each do |text|
					if text[:type] == :break
						s << "<a:br />"
					elsif text[:type] == :paragraph
						s << "<a:r>"
							rPr(s, text)
							s << "<a:t>#{PowerPointer::escape_tag text[:text]}</a:t>"
						s << "</a:r>"
					end
				end
			s << "</a:p>"

			s
		end
	end
end
