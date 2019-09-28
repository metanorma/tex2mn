require "minitest/autorun"
require "helper"

class TestMathInline < Minitest::Test
  def test_inline_math
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \documentclass{metanorma}
      \begin{document}
        The identity $e^{i\pi}+1=0$ is pretty neat.
      \end{document}
    INPUT
      The identity stem:[e^{i\\pi}+1=0] is pretty neat.

    OUTPUT
  end
end
