# SimpleSerializer
[![Gem Version](https://badge.fury.io/rb/simple-serializer.svg)](https://badge.fury.io/rb/simple-serializer)

## Install

Gemfile:
```ruby
gem 'simple-serializer'
```

Shell:
```sh
gem install simple-serializer
```

## Usage
```ruby
require 'simple-serializer'

class Account < ApplicationRecord; end

class AccountSerializer < SimpleSerializer
  # define multiple attributes to include in the serialized object
  attributes :id, :created_at, :updated_at

  # define one attribute at a time
  attribute :email_address

  # provide an alias for an attribute (object_attr_name: :new_name)
  attribute customer_phone_number: :phone_number

  # define a proc for computed attributes
  attribute(:name) { [first_name, last_name].join(' ') }
  
  # serialize nested objects
  serialize(:address) do
    attributes :line1, :line2, :city, :state, :zipcode
  end
end

# You can serialize an object by calling .to_h or .to_json on the serializer
AccountSerializer.to_h(Account.first)

# if you pass in an enumerable instead of a single object, each one will be serialized
AccountSerializer.to_h(Account.all)

# include YourSerializer.helpers in your object's class to get a more convenient interface
class Account
  include AccountSerializer.helpers 
end

# this is the same as calling AccountSerializer.to_h[Account.first]
Account.first.to_h

```

