# TODO Add action drop for dropping user from the MySQL database.
actions :create, :update

default_action :create

attribute :user,
          kind_of: String,
          name_attribute: true

attribute :password,
          kind_of: String,
          required: true

attribute :host,
          kind_of: String,
          required: true
