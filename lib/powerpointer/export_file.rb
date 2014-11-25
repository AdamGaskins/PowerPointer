module PowerPointer
    class ExportFile
        def initialize(path, filename)
            @path = path
            @filename = filename
            @content = ""
        end
        
        def <<(content)
            @content << content
        end    
        
        def get_content
            @content
        end
        
        def get_path
            @path
        end
        
        def get_filename
            @filename
        end
        
        def get_full_path
            (@path + @filename)
        end
    end
end