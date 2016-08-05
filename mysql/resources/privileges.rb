actions :grant, :revoke

default_action :grant

attribute :user,
          kind_of: String,
          required: true

attribute :host,
          kind_of: String,
          required: true

attribute :database,
          kind_of: String,
          required: true

attribute :table,
          kind_of: String,
          default: '*',
          required: false

# All privileges are granted or revoked for MySQL users.
#
##attribute :privilege,                                                           
##           kind_of: String,                                                      
##           required: false,                                                      
##           default: 'ALL'  
