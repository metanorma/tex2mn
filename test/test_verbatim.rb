# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestFigures < Minitest::Test
  def test_just_verbatim
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      ....
       __v_
      (____\/{
      ....

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
      \begin{verbatim}
       __v_
      (____\/{
      \end{verbatim}
      \end{document}
    INPUT
  end

  def test_verbatim_in_a_figure
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[ascii-whale]]
      .A cute ascii whale
      [alt=A cute ascii whale]
      ....
       __v_
      (____\/{
      ....

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
      \begin{figure}
      \label{ascii-whale}
      \caption{A cute ascii whale}
      \mn{alt=A cute ascii whale}
      \begin{verbatim}
       __v_
      (____\/{
      \end{verbatim}
      \end{figure}
      \end{document}
    INPUT
  end
end
