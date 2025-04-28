# p is for pink

module Kernel
    def p(*args)
        pink_bold = "\e[1;35m"
        reset = "\e[0m"

        args.each do |arg|
            puts "#{pink_bold}#{arg.inspect}#{reset}"
        end
    end
end
