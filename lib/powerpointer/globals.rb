module PowerPointer
    XML_HEADER = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"

    def self.escape_string str
        return str.to_s.gsub("\"", "\\\"")
    end

    def self.escape_tag str
        return str.to_s.gsub("<", "&lt;").gsub(">", "&gt;")
    end
end