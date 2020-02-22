# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestInlineAttribute < Minitest::Test
  def test_inline_attribute
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
        This [role]#snippet# has a role.

        This [.class]#snippet# has a class.

        This [#id]#snippet# has an id.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        This \att[role]{snippet} has a role.

        This \att[.class]{snippet} has a class.

        This \att[#id]{snippet} has an id.

      \end{document}
    INPUT
  end
end
