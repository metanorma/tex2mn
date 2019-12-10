# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestTodos < Minitest::Test
  def test_todo_without_attributes
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      [TODO]
      ====
      Lorem ipsum.
      ====

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}

        Previous paragraph.

        \begin{todo}
          Lorem ipsum.
        \end{todo}

        Following paragraph.
      \end{document}
    INPUT
  end

  def test_todo_with_attributes
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      [TODO,reviewer="John Doe",date=20180125T0121,from=A,to=B]
      ====
      Lorem ipsum.
      ====

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}

        Previous paragraph.

        \begin{todo}
          \mn{reviewer="John Doe",date=20180125T0121,from=A,to=B}
          Lorem ipsum.
        \end{todo}

        Following paragraph.
      \end{document}
    INPUT
  end
end
