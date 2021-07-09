# frozen_string_literal: true

require 'gemtext'

module Gmi2html
  class Document
    class << self
      def from_file(filename)
        File.open(filename) do |file|
          new file
        end
      end
    end

    def initialize(doc)
      @document_io = wrap_document(doc)
      @gemtext = gemtext
    end

    def to_html
      renderer.to_html
    end

    private

    def wrap_document(doc)
      doc.is_a?(String) ? StringIO.new(doc) : doc
    end

    def gemtext
      ::Gemtext::Parser.new(@document_io).parse
    end

    def renderer
      Renderer.new @gemtext.nodes
    end
  end
end
