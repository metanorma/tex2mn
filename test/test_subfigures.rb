# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestSubfigures < Minitest::Test
  def test_subfigure
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[fig:whole]]
      .A figure with two subfigures
      ====
      [[fig:left]]
      .A subfigure on the left
      image::left.jpg[]

      [[fig:right]]
      .A subfigure on the right
      image::right.jpg[]

      ====

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{figure}\centering
          \begin{subfigure}[b]{0.4\textwidth}
            \includegraphics[width=\textwidth]{left.jpg}
            \caption{A subfigure on the left}
            \label{fig:left}
          \end{subfigure}
          \qquad
          \begin{subfigure}[b]{0.4\textwidth}
            \includegraphics[width=\textwidth]{right.jpg}
            \caption{A subfigure on the right}
            \label{fig:right}
          \end{subfigure}
          \caption{A figure with two subfigures}
          \label{fig:whole}
        \end{figure}
      \end{document}
    INPUT
  end
end
