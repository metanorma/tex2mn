require "minitest/autorun"
require "helper"

class TestMathDisplay < Minitest::Test
  def test_display_math_inline
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      The identity

      [stem]
      ++++
      e^{i\pi}+1=0
      ++++

      is pretty neat.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        The identity \[e^{i\pi}+1=0\] is pretty neat.
      \end{document}
    INPUT
  end

  def test_display_math_embedded
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      The identity

      [stem]
      ++++
      e^{i\pi}+1=0
      ++++

      is pretty neat.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        The identity
        \[e^{i\pi}+1=0\]
        is pretty neat.
      \end{document}
    INPUT
  end

  def test_display_math_separated
    skip "How should we handle the rigidity of asciidoc paragraphs?"
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      The identity

      [stem]
      ++++
      e^{i\pi}+1=0
      ++++

      is pretty neat.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        The identity

        \[e^{i\pi}+1=0\]

        is pretty neat.
      \end{document}
    INPUT
  end
end
