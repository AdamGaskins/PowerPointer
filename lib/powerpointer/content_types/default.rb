module PowerPointer
    class ContentTypes
        class Default
            def initialize(extension, contentType)
                @extension = extension
                @contentType = contentType
            end
            
            def getExtension
                @extension
            end
            
            def getContentType
                @contentType
            end
            
            def to_xml
                "<Default Extension=\"#{@extension}\" ContentType=\"#{@contentType}\" />"
            end
        end
    end
end