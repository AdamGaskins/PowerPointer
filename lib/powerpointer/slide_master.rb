module PowerPointer
	class SlideMaster < SlideKind
		@@slide_layout_count = 0
		@@next_unique_id = 2147483648
		def initialize(name, presentation)
			@@slide_layout_count += 1
			@@next_unique_id += 1
			_initialize @@slide_layout_count, @@next_unique_id, "slideMaster", "sldMaster", name, :slide_master

			@presentation = presentation

			@clr_map = {
				bg1:"lt1",
				tx1:"dk1",
				bg2:"lt2",
				tx2:"dk2",
				accent1:"accent1",
				accent2:"accent2",
				accent3:"accent3",
				accent4:"accent4",
				accent5:"accent5",
				accent6:"accent6",
				hlink:"hlink",
				folHlink:"folHlink",
			}

			@slide_layouts = []
		end

		attr_accessor :presentation, :slide_layouts

		def _add_slide_layout layout
			@slide_layouts << layout
			@relationships.add layout.relationship_id, PowerPointer::SCHEMAS[:slide_layout][:relationship], "../slideLayouts/#{layout.file_name}"
		end

		def custom_xml tag, buffer, folder, presentation, package
			if tag == "spTree"
			elsif tag == "sldMaster"
				# Export color map
				buffer << "<p:clrMap "
				@clr_map.each do |key, value|
					buffer << key.to_s
					buffer << "=\""
					buffer << PowerPointer::escape_string(value)
					buffer << "\" "
				end
				buffer << "/>"

				# Export slide layout list
				buffer << "<p:sldLayoutIdLst>"
				@slide_layouts.each do |slide_layout|
					buffer << "<p:sldLayoutId id=\"#{slide_layout.unique_id}\" r:id=\"#{slide_layout.relationship_id}\" />"
					slide_layout.export_xml folder, presentation, package
				end
				buffer << "</p:sldLayoutIdLst>"
			end
		end
	end
end
