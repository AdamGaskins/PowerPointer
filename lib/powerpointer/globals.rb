module PowerPointer
    XML_HEADER = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"

    SCHEMAS = {
        relationship: {
            root: "http://schemas.openxmlformats.org/package/2006/relationships",
            content_type: "application/vnd.openxmlformats-package.relationships+xml"
        },
        presentation: {
            root: "http://schemas.openxmlformats.org/presentationml/2006/main",
            relationship: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument",
            content_type: "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"
        },
        slide: {
            root: "http://schemas.openxmlformats.org/presentationml/2006/main",
            relationship: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide",
            content_type: "application/vnd.openxmlformats-officedocument.presentationml.slide+xml"
        },
        slide_layout: {
            root: "http://schemas.openxmlformats.org/presentationml/2006/main",
            relationship: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout",
            content_type: "application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml"
        },
        slide_master: {
            root: "http://schemas.openxmlformats.org/presentationml/2006/main",
            relationship: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster",
            content_type: "application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"
        },
        pic: {
            relationship: "http://schemas.openxmlformats.org/officeDocument/2006/relationships/image",
        },
        drawingML: "http://schemas.openxmlformats.org/drawingml/2006/main",
        content_types: "http://schemas.openxmlformats.org/package/2006/content-types"
    }

    def self.escape_string str
        return str.to_s.gsub("\"", "\\\"")
    end

    def self.escape_tag str
        return str.to_s.gsub("<", "&lt;").gsub(">", "&gt;")
    end
end
