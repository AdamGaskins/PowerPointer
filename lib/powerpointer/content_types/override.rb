module PowerPointer
    class ContentTypes
        class Override
            def initialize(partName, contentType)
                @partName = partName
                @contentType = contentType
            end
            
            def getPartName
                @partName
            end
            
            def getContentType
                @contentType
            end
            
            def to_xml
                "<Override PartName=\"#{@partName}\" ContentType=\"#{@contentType}\" />"
            end
        end
    end
end