require "minitest/autorun"
require "helper"

class TestFigures < Minitest::Test
  def test_naked_tabular
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [cols=2*]
      |===
      | A
      | B

      | C
      | D
      |===

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{tabular}{ll}
          A & B \\
          C & D \\
        \end{tabular}
      \end{document}
    INPUT
  end

  def test_tabular_only
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [cols=2*]
      |===
      | A
      | B

      | C
      | D
      |===

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{table}
          \begin{tabular}{ll}
            A & B \\
            C & D \\
          \end{tabular}
        \end{table}
      \end{document}
    INPUT
  end

  def test_label_without_caption
    # NOTE: the label is ignored if there's no caption
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [cols=2*]
      |===
      | A
      | B

      | C
      | D
      |===

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{table}
          \label{tab:example}
          \begin{tabular}{ll}
            A & B \\
            C & D \\
          \end{tabular}
        \end{table}
      \end{document}
    INPUT
  end

  def test_caption_without_label
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      .This is the caption
      [cols=2*]
      |===
      | A
      | B

      | C
      | D
      |===

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{table}
          \caption{This is the caption}
          \begin{tabular}{ll}
            A & B \\
            C & D \\
          \end{tabular}
        \end{table}
      \end{document}
    INPUT
  end

  def test_complete
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[tab:example]]
      .This is the caption
      [cols=2*]
      |===
      | A
      | B

      | C
      | D
      |===

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{table}
          \label{tab:example}
          \caption{This is the caption}
          \begin{tabular}{ll}
            A & B \\
            C & D \\
          \end{tabular}
        \end{table}
      \end{document}
    INPUT
  end
end
