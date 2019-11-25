# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestSubfigures < Minitest::Test
  def test_subfigure
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[fig:example]]
      .This is the caption
      image::example.jpg[]

      *Key*

      A::
      Foo
      B::
      Bar
      C::
      Baz

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{figure}
          \includegraphics{example.jpg}
          \label{fig:example}
          \caption{This is the caption}
          \paragraph*{Key}
          \begin{key}
            \item[A] Foo
            \item[B] Bar
            \item[C] Baz
          \end{key}
        \end{figure}
      \end{document}
    INPUT
  end
end
