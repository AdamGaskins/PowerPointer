module PowerPointer
	class Slide < SlideKind
		@@slide_count = 0
		@@next_unique_id = 256
		def initialize name, slide_layout
			@@slide_count += 1
			@@next_unique_id += 1
			_initialize @@slide_count, @@next_unique_id, "slide", "sld", name, :slide
			@relationships.add slide_layout.relationship_id, SCHEMAS[:slide_layout][:relationship], "../slideLayouts/#{slide_layout.file_name}"
		end

		def custom_xml tag, buffer, folder, presentation, package, tmpFolder
			# buffer << ""
		end
	end
end
