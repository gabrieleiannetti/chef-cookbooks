module Mysql

  class Connection

    @@is_package_loaded = false
    @@conn = nil
    

    def self.load_mysql_package()
      
      unless $is_package_loaded

        cmd = Mixlib::ShellOut.new("ruby -e 'puts $:'")                               
        cmd.run_command                                                               
                                                                                            
        cmd.error!                                                                    
        cmd.stdout.split("\n").map { |path| $: << path }                              
                                                                                                
        require 'mysql2' 

        $is_package_loaded = true

      end
    end  


    def self.init_class(host, username, password)
      
      self.load_mysql_package() 

      @@conn = Mysql2::Client.new(:host => host, :username => username, :password => password)

    end


    def self.instance()
      return @@conn
    end

  end
end
