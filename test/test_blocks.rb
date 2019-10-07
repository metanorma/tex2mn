# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestAdmonitions < Minitest::Test
  def test_block_typologies
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [.requirement]
      ====
      This is a requirement block.
      ====

      [.recommendation]
      ====
      This is a recommendation block.
      ====

      [.permission]
      ====
      This is a permission block.
      ====

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{requirement}
          This is a requirement block.
        \end{requirement}

        \begin{recommendation}
          This is a recommendation block.
        \end{recommendation}

        \begin{permission}
          This is a permission block.
        \end{permission}
      \end{document}
    INPUT
  end

  def test_block_embeddings
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Before A.

      [.requirement]
      ====
      Content A.
      ====

      Before B.

      [.requirement]
      ====
      Content B.
      ====

      Before C.

      [.requirement]
      ====
      Content C.
      ====

      After C.

      [.requirement]
      ====
      Content D.
      ====

      After D.

      [.requirement]
      ====
      Content E.
      ====

      After E.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        Before A.

        \begin{requirement}Content A.\end{requirement}

        Before B.
        \begin{requirement}Content B.\end{requirement}

        Before C.
        \begin{requirement}Content C.\end{requirement}
        After C.

        \begin{requirement}Content D.\end{requirement}
        After D.

        \begin{requirement}Content E.\end{requirement}

        After E.
      \end{document}
    INPUT
  end

  def test_block_contents
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [.requirement]
      ====
      One paragraph, one line.
      ====

      [.requirement]
      ====
      One paragraph, +
      two lines.
      ====

      [.requirement]
      ====
      Two paragraphs.

      Two lines.
      ====

      [.requirement]
      ====
      Two paragraphs.

      Two lines.
      ====

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{requirement}
          One paragraph, one line.
        \end{requirement}

        \begin{requirement}
          One paragraph,\newline two lines.
        \end{requirement}

        \begin{requirement}
          Two paragraphs.\par Two lines.
        \end{requirement}

        \begin{requirement}
          Two paragraphs.

          Two lines.
        \end{requirement}
      \end{document}
    INPUT
  end

  def test_block_nesting
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [.requirement]
      ====
      Level 1

      [.requirement]
      =====
      Level 2

      [.requirement]
      ======
      Level 3
      ======
      =====
      ====

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{requirement}
          Level 1
          \begin{requirement}
            Level 2
            \begin{requirement}
              Level 3
            \end{requirement}
          \end{requirement}
        \end{requirement}
      \end{document}
    INPUT
  end

  def test_block_substructure
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [.requirement]
      ====
      This is a requirement.

      [.specification]
      --
      This is a specification.
      --

      [.measurement-target]
      --
      This is a measurement target.
      --

      [.verification]
      --
      This is a verification.
      --

      [.import]
      --
      This is an import.
      --
      ====

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{requirement}
          This is a requirement.
          \begin{specification}
            This is a specification.
          \end{specification}
          \begin{measurement-target}
            This is a measurement target.
          \end{measurement-target}
          \begin{verification}
            This is a verification.
          \end{verification}
          \begin{import}
            This is an import.
          \end{import}
        \end{requirement}
      \end{document}
    INPUT
  end
end
