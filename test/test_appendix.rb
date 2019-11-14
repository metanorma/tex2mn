# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestAppendix < Minitest::Test
  def test_single_appendix
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
    == Foo

    Lorem ipsum.

    [appendix]
    == Bar

    Lorem ipsum.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \section{Foo}

        Lorem ipsum.

        \appendix

        \section{Bar}

        Lorem ipsum.
      \end{document}
    INPUT
  end

  def test_multiple_appendices
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
    == Foo

    Lorem ipsum.

    [appendix]
    == Bar

    Lorem ipsum.

    [appendix]
    == Baz

    Lorem ipsum.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \section{Foo}

        Lorem ipsum.

        \appendix

        \section{Bar}

        Lorem ipsum.

        \section{Baz}

        Lorem ipsum.
      \end{document}
    INPUT
  end

  def test_extra_attributes
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
    == Foo

    Lorem ipsum.

    [appendix,obligation=informative]
    == Bar

    Lorem ipsum.

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \section{Foo}

        Lorem ipsum.

        \appendix

        \section{Bar}
        \mna{obligation=informative}

        Lorem ipsum.
      \end{document}
    INPUT
  end
end
