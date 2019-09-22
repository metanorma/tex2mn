require "minitest/autorun"
require "helper"

class TestMwe < Minitest::Test
  def test_file_comparison
    assert_equal render_file("test_mwe/test_mwe.tex"), read_file("test_mwe/test_mwe.xml")
  end

  def test_string_comparison
    assert_equal render_string(<<~'INPUT'), <<~OUTPUT
      \begin{document}
        \section{Foobar}
        Lorem ipsum.
      \end{document}
    INPUT

      == Foobar

      Lorem ipsum.

    OUTPUT
  end
end
