module PowerPointer
	class SlideLayout < SlideKind
		@@slide_layout_count = 0
		@@unique_id = 2147483648
		def initialize(name, master)
			@@slide_layout_count += 1
			@@unique_id += 1
			_initialize @@slide_layout_count, @@unique_id, "slideLayout", "sldLayout", name, :slide_layout
			@relationships.add master.relationship_id, SCHEMAS[:slide_master][:relationship], "../slideMasters/#{master.file_name}"
			master._add_slide_layout self
			@master = master
			@presentation_relationship = false
		end

		attr_accessor :master

		def custom_xml tag, buffer, folder, presentation, package, tmpFolder
			# buffer << ""
		end
	end
end
