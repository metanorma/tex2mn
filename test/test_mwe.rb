# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestMwe < Minitest::Test
  def test_file_comparison
    assert_equal read_file("test_mwe/test_mwe.adoc"), render_file("test_mwe/test_mwe.tex")
  end

  def test_string_comparison
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      == Foobar

      Lorem ipsum.

    OUTPUT
      \begin{document}
        \section{Foobar}
        Lorem ipsum.
      \end{document}
    INPUT
  end
end
