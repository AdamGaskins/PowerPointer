module PowerPointer
	class SlideMaster < SlideKind
		@@slide_layout_count = 0
		def initialize(name)
			@@slide_layout_count += 1
			_initialize @@slide_layout_count, "slideMaster", name

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

		def add_slide_layout layout
			if layout.respond_to? :set_master
				layout.set_master self
				@slide_layouts << layout
				@relationships.add @layout.get_relationship_id, SCHEMAS[:slideLayout][:relationship], "../slideLayouts/#{layout.file_name}"
			end
		end

		def custom_xml buffer
			# Export color map
			buffer << "<p:clrMap "
			@clr_map.each do |key, value|
				buffer << key
				buffer << "=\""
				buffer << PowerPointer::escape_string(value)
				buffer << "\" "
			end
			buffer << "/>"

			# Export slide layout list
			buffer << "<p:sldLayoutIdLst>"
			@slide_layouts.each do |slide_layout|
				buffer << "<p:sldLayoutId id=\"#{slide_layout.id}\" r:id=\"#{slide_layout.relationship_id}\" />"
			end
			buffer << "</p:sldLayoutIdLst>"
		end
	end
end
