# frozen_string_literal: true

class SimpleSerializer
  VERSION = '0.1.7'

  def initialize(object, opts = {})
    @include = opts[:include] || []
    @exclude = opts[:exclude] || []
    @object = object
  end

  def to_h
    return @object.map(&method(:to_h_single)) if @object.is_a?(Enumerable)

    to_h_single(@object)
  end

  class << self
    attr_reader :fields

    def inherited(sub)
      sub.instance_variable_set(:@fields, fields.to_h.dup)
    end

    def helpers
      serializer = self

      Module.new.tap do |m|
        m.define_singleton_method(:included) do |base|
          base.define_method(:to_h) { |o = {}| serializer.to_h(self, o) }

          base.define_method(:to_json) { |o = {}| serializer.to_json(self, o) }

          base.define_method(:serializer_class) { serializer }
        end
      end
    end

    def [](object)
      to_h(object)
    end

    def to_h(object, opts = {})
      new(object, opts).to_h
    end

    def to_json(object, opts = {})
      to_h(object, opts).to_json
    end

    def attributes(*fields, **named, &block)
      @fields ||= {}

      fields.each { |k| @fields[k] = block }

      @fields.merge!(named)
    end

    alias attribute attributes

    def serialize(field, &block)
      attributes(field => Class.new(SimpleSerializer, &block))
    end
  end

  private

  def to_h_single(object)
    self.class.fields&.merge(Hash[@include.zip])&.reduce({}) do |h, (k, v)|
      next h if @exclude.include?(k)

      h.merge!(serialize_key_val(object, k, v))
    end
  end

  def serialize_key_val(obj, key, val)
    return { key => nest(obj.send(key)) } if val.nil?

    return { key => nest(obj.instance_eval(&val)) } if val.is_a?(Proc)

    if val.is_a?(Class) && val < SimpleSerializer
      return { key => val[obj.send(key)] }
    end

    { val => nest(obj.send(key)) }
  end

  def nest(result)
    serializable = result.respond_to?(:serializer_class)
    serializable_array = result.is_a?(Enumerable) &&
                         result.first.respond_to?(:serializer_class)

    return result.serializer_class.to_h(result) if serializable
    return result.first.serializer_class.to_h(result) if serializable_array

    result
  end
end
