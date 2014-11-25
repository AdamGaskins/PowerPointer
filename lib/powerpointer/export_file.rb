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
        
        def get_full_path (leading_slash = false)
            if leading_slash
                return "/" + @path + @filename
            else
                return @path + @filename
            end
        end
    end
end