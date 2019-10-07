# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestDescriptionLists < Minitest::Test
  def test_short_items
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      A::
      Foo
      B::
      Bar
      C::
      Baz

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{description}
          \item [A] Foo
          \item [B] Bar
          \item [C] Baz
        \end{description}

        Following paragraph.
      \end{document}
    INPUT
  end

  def test_long_items
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      A::
      No lines here.
      B::
      This is a paragraph +
      containing a line break.
      C::
      This is a paragraph.
      +
      This is another paragraph.

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{description}
          \item [A] No lines here.

          \item [B] This is a paragraph\\
                containing a line break.

          \item [C] This is a paragraph.

                This is another paragraph.
        \end{description}

        Following paragraph.
      \end{document}
    INPUT
  end

  def test_nesting
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Previous paragraph.

      A0::
      A0
      B0::
      B0
      A1:::
      A1
      B1:::
      B1
      C0::
      C0
      A1:::
      A1
      B1:::
      B1
      A2::::
      A2
      B2::::
      B2
      A3:::::
      A3
      B3:::::
      B3
      C3:::::
      C3
      C2::::
      C2
      C1:::
      C1

      Following paragraph.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Previous paragraph.

        \begin{description}
          \item [A0] A0
          \item [B0] B0
          \begin{description}
            \item [A1] A1
            \item [B1] B1
          \end{description}
          \item [C0] C0
          \begin{description}
            \item [A1] A1
            \item [B1] B1
            \begin{description}
              \item [A2] A2
              \item [B2] B2
              \begin{description}
                \item [A3] A3
                \item [B3] B3
                \item [C3] C3
              \end{description}
              \item [C2] C2
            \end{description}
            \item [C1] C1
          \end{description}
        \end{description}

        Following paragraph.
      \end{document}
    INPUT
  end
end
