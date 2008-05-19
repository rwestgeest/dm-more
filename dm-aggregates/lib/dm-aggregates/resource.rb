module DataMapper
  module Resource
    module ClassMethods

      # Count results (given the conditions)
      #
      # ==== Example
      #   Friend.count # returns count of all friends
      #   Friend.count(:age.gt => 18) # returns count of all friends older then 18
      #   Friend.count(:conditions => [ 'gender = ?', 'female' ]) # returns count of all your female friends
      #   Friend.count(:address) # returns count of all friends with an address (NULL values are not included)
      #   Friend.count(:address, :age.gt => 18) # returns count of all friends with an address that are older then 18
      #   Friend.count(:adress, :conditions => [ 'gender = ?', 'female' ]) # returns count of all your female friends with an address
      #
      # ==== Parameters
      # property<Symbol>:: of the property you with to count (optional)
      # opts<Hash, Symbol>:: of the conditions
      #
      # ==== Returns
      # <Integer>:: with the count of the results
      #---
      # @public
      def count(*args)
        with_repository_and_property(*args) do |repository,property,options|
          repository.count(self, property, options)
        end
      end

      # Get the lowest value of a property
      #
      # ==== Example
      #   Friend.min(:age) # returns the age of the youngest friend
      #   Friend.min(:age, :conditions => [ 'gender = ?', 'female' ]) # returns the age of the youngest female friends
      #
      # ==== Parameters
      # property<Symbol>:: the property you wish to get the lowest value of
      # opts<Hash, Symbol>:: the conditions
      #
      # ==== Returns
      # <Integer>:: return the lowest value of a property given the conditions
      #---
      # @public
      def min(*args)
        with_repository_and_property(*args) do |repository,property,options|
          check_property_is_number(property)
          repository.min(self, property, options)
        end
      end

      # Get the highest value of a property
      #
      # ==== Example
      #   Friend.max(:age) # returns the age of the oldest friend
      #   Friend.max(:age, :conditions => [ 'gender = ?', 'female' ]) # returns the age of the oldest female friends
      #
      # ==== Parameters
      # property<Symbol>:: the property you wish to get the highest value of
      # opts<Hash, Symbol>:: the conditions
      #
      # ==== Returns
      # <Integer>:: return the highest value of a property given the conditions
      #---
      # @public
      def max(*args)
        with_repository_and_property(*args) do |repository,property,options|
          check_property_is_number(property)
          repository.max(self, property, options)
        end
      end

      # Get the average value of a property
      #
      # ==== Example
      #   Friend.avg(:age) # returns the average age of friends
      #   Friend.avg(:age, :conditions => [ 'gender = ?', 'female' ]) # returns the average age of the female friends
      #
      # ==== Parameters
      # property<Symbol>:: the property you wish to get the average value of
      # opts<Hash, Symbol>:: the conditions
      #
      # ==== Returns
      # <Integer>:: return the average value of a property given the conditions
      #---
      # @public
      def avg(*args)
        with_repository_and_property(*args) do |repository,property,options|
          check_property_is_number(property)
          repository.avg(self, property, options)
        end
      end

      # Get the total value of a property
      #
      # ==== Example
      #   Friend.sum(:age) # returns total age of all friends
      #   Friend.max(:age, :conditions => [ 'gender = ?', 'female' ]) # returns the total age of all female friends
      #
      # ==== Parameters
      # property<Symbol>:: the property you wish to get the total value of
      # opts<Hash, Symbol>:: the conditions
      #
      # ==== Returns
      # <Integer>:: return the total value of a property given the conditions
      #---
      # @public
      def sum(*args)
        with_repository_and_property(*args) do |repository,property,options|
          check_property_is_number(property)
          repository.sum(self, property, options)
        end
      end

      # def first(*args)
      #   with_repository_and_property(*args) do |repository,property,options|
      #     raise NotImplementedError
      #   end
      # end
      #
      # def last(*args)
      #   with_repository_and_property(*args) do |repository,property,options|
      #     raise NotImplementedError
      #   end
      # end

      private

      def with_repository_and_property(*args, &block)
        options       = Hash === args.last ? args.pop : {}
        property_name = args.shift

        repository(options[:repository]) do |repository|
          property = properties(repository.name)[property_name] if property_name
          yield repository, property, options
        end
      end

      def check_property_is_number(property)
        raise ArgumentError, "+property+ should be an Integer, Float or BigDecimal, but was #{property.nil? ? 'nil' : property.type.class}" unless property && [ Fixnum, Float, BigDecimal ].include?(property.type)
      end

    end
  end
end
