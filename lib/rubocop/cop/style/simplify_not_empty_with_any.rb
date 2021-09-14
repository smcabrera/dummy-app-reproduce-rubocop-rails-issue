module RuboCop
  module Cop
    module Style
      # `array.any?` is a simplified way to say `!array.empty?`
      #
      # @example
      #   # bad
      #   !array.empty?
      #
      #   # good
      #   array.any?
      class SimplifyNotEmptyWithAny < Base
        MSG = 'Use `.any?` and remove the negation part.'.freeze

        def_node_matcher :not_empty_call?, <<~PATTERN
          (send (send $(...) :empty?) :!)
        PATTERN

        RESTRICT_ON_SEND = [:!].freeze # optimization: don't call `on_send` unless
                                       # the method name is in this list
        def on_send(node)
          return unless not_empty_call?(node)

          add_offense(node)
        end
      end
    end
  end
end
