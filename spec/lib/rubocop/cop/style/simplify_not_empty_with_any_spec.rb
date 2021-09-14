require 'rubocop'
require 'rubocop/rspec/support'
require_relative '../../../../../lib/rubocop/cop/lint/simplify_not_empty_with_any'

describe RuboCop::Cop::Lint::SimplifyNotEmptyWithAny, :config do
  it 'registers an offense when using `!a.empty?`' do
    expect_offense(<<~RUBY)
      !array.empty?
      ^^^^^^^^^^^^^ Use `.any?` and remove the negation part.
    RUBY
  end

  it 'does not register an offense when using `.any?` or `.empty?`' do
    expect_no_offenses(<<~RUBY)
      array.any?
      array.empty?
    RUBY
  end
end
