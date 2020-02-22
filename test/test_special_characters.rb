# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestTitle < Minitest::Test
  def test_quotation_marks_and_apostrophes
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      The ’80s.
      The students’ books.
      I can’t find Joey’s house.
      Single quotes are ‘pretty neat’.
      Double quotes are “pretty neat”.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        The '80s.
        The students' books.
        I can't find Joey's house.
        Single quotes are `pretty neat'.
        Double quotes are ``pretty neat''.
      \end{document}
    INPUT
  end
end
