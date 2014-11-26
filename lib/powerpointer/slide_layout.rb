module PowerPointer
	class SlideLayout < SlideKind
		@@slide_layout_count = 0
		def initialize(name)
			@@slide_layout_count += 1
			_initialize @@slide_layout_count, "slideLayout", name
		end

		def set_master master
			@relationships.add
		end

		def custom_xml buffer
			# buffer << ""
		end
	end
end
