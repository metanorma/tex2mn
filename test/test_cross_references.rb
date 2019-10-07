# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestCrossReferences < Minitest::Test
  def test_internal_reference
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Go look at <<sec:test>>.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Go look at \ref{sec:test}.
      \end{document}
    INPUT
  end

  def test_internal_reference_with_label
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Go look at <<sec:test, this>>.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Go look at \hyperref[sec:test]{this}.
      \end{document}
    INPUT
  end

  def test_external_reference
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Go look at https://www.metanorma.com/.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Go look at \url{https://www.metanorma.com/}.

      \end{document}
    INPUT
  end

  def test_external_reference_with_label
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Go look at https://www.metanorma.com/[Metanorma home].

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Go look at \href{https://www.metanorma.com/}{Metanorma home}.

      \end{document}
    INPUT
  end
end
