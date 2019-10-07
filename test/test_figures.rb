# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestFigures < Minitest::Test
  def test_picture_only
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[fig1]]
      image::example.jpg[]

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{figure}
          \includegraphics{example.jpg}
        \end{figure}
      \end{document}
    INPUT
  end

  def test_label_without_caption
    # NOTE: the label is ignored if there's no caption
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[fig1]]
      image::example.jpg[]

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{figure}
          \label{fig:example}
          \includegraphics{example.jpg}
        \end{figure}
      \end{document}
    INPUT
  end

  def test_caption_without_label
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[S0.F1]]
      .This is the caption
      image::example.jpg[]

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{figure}
          \caption{This is the caption}
          \includegraphics{example.jpg}
        \end{figure}
      \end{document}
    INPUT
  end

  def test_complete
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      [[fig:example]]
      .This is the caption
      image::example.jpg[]

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{figure}
          \label{fig:example}
          \caption{This is the caption}
          \includegraphics{example.jpg}
        \end{figure}
      \end{document}
    INPUT
  end
end
