module PowerPointer
	class Slide < SlideKind
		@@slide_count = 0
		def initialize name
			@@slide_count += 1
			_initialize @@slide_count, "slide", name
		end

		def custom_xml buffer
			# buffer << ""
		end

		def set_slide_layout slide_layout
			if slide_layout.respond_to? :set_master
				@relationships.add slide_layout.relationship_id, SCHEMAS[:slide_layout][:relationship], "../slideLayouts/#{slide_layout.file_name}"
			end
		end
	end
end
