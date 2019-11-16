# frozen_string_literal: true

require "minitest/autorun"
require "helper"

class TestNestedLists < Minitest::Test
  def test_itemize_to_level_4
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      * Itemize
      ** Itemize
      *** Itemize
      **** Itemize
      **** Enumerate
      **** Description
      *** Enumerate
      . Itemize
      . Enumerate
      . Description
      *** Description
      Itemize::
      Enumerate::
      Description::
      ** Enumerate
      . Itemize
      *** Itemize
      *** Enumerate
      *** Description
      . Enumerate
      .. Itemize
      .. Enumerate
      .. Description
      . Description
      Itemize::
      Enumerate::
      Description::
      ** Description
      Itemize::
      *** Itemize
      *** Enumerate
      *** Description
      Enumerate::
      . Itemize
      . Enumerate
      . Description
      Description::
      Itemize:::
      Enumerate:::
      Description:::
      * Enumerate
      . Itemize
      ** Itemize
      *** Itemize
      *** Enumerate
      *** Description
      ** Enumerate
      .. Itemize
      .. Enumerate
      .. Description
      ** Description
      Itemize::
      Enumerate::
      Description::
      . Enumerate
      .. Itemize
      ** Itemize
      ** Enumerate
      ** Description
      .. Enumerate
      ... Itemize
      ... Enumerate
      ... Description
      .. Description
      Itemize::
      Enumerate::
      Description::
      . Description
      Itemize::
      ** Itemize
      ** Enumerate
      ** Description
      Enumerate::
      .. Itemize
      .. Enumerate
      .. Description
      Description::
      Itemize:::
      Enumerate:::
      Description:::
      * Description
      Itemize::
      ** Itemize
      *** Itemize
      *** Enumerate
      *** Description
      ** Enumerate
      . Itemize
      . Enumerate
      . Description
      ** Description
      Itemize:::
      Enumerate:::
      Description:::
      Enumerate::
      . Itemize
      ** Itemize
      ** Enumerate
      ** Description
      . Enumerate
      .. Itemize
      .. Enumerate
      .. Description
      . Description
      Itemize:::
      Enumerate:::
      Description:::
      Description::
      Itemize:::
      ** Itemize
      ** Enumerate
      ** Description
      Enumerate:::
      . Itemize
      . Enumerate
      . Description
      Description:::
      Itemize::::
      Enumerate::::
      Description::::

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{itemize}
          \item Itemize
            \begin{itemize}
              \item Itemize
                \begin{itemize}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{itemize}
              \item Enumerate
                \begin{enumerate}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{enumerate}
              \item Description
                \begin{description}
                  \item[Itemize]
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item[Enumerate]
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item[Description]
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{description}
            \end{itemize}
          \item Enumerate
            \begin{enumerate}
              \item Itemize
                \begin{itemize}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{itemize}
              \item Enumerate
                \begin{enumerate}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{enumerate}
              \item Description
                \begin{description}
                  \item[Itemize]
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item[Enumerate]
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item[Description]
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{description}
            \end{enumerate}
          \item Description
            \begin{description}
              \item[Itemize]
                \begin{itemize}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{itemize}
              \item[Enumerate]
                \begin{enumerate}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{enumerate}
              \item[Description]
                \begin{description}
                  \item[Itemize]
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item[Enumerate]
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item[Description]
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{description}
            \end{description}
        \end{itemize}
      \end{document}
    INPUT
  end

  def test_enumerate_to_level_4
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      . Itemize
      * Itemize
      ** Itemize
      *** Itemize
      *** Enumerate
      *** Description
      ** Enumerate
      .. Itemize
      .. Enumerate
      .. Description
      ** Description
      Itemize::
      Enumerate::
      Description::
      * Enumerate
      .. Itemize
      ** Itemize
      ** Enumerate
      ** Description
      .. Enumerate
      ... Itemize
      ... Enumerate
      ... Description
      .. Description
      Itemize::
      Enumerate::
      Description::
      * Description
      Itemize::
      ** Itemize
      ** Enumerate
      ** Description
      Enumerate::
      .. Itemize
      .. Enumerate
      .. Description
      Description::
      Itemize:::
      Enumerate:::
      Description:::
      . Enumerate
      .. Itemize
      * Itemize
      ** Itemize
      ** Enumerate
      ** Description
      * Enumerate
      ... Itemize
      ... Enumerate
      ... Description
      * Description
      Itemize::
      Enumerate::
      Description::
      .. Enumerate
      ... Itemize
      * Itemize
      * Enumerate
      * Description
      ... Enumerate
      .... Itemize
      .... Enumerate
      .... Description
      ... Description
      Itemize::
      Enumerate::
      Description::
      .. Description
      Itemize::
      * Itemize
      * Enumerate
      * Description
      Enumerate::
      ... Itemize
      ... Enumerate
      ... Description
      Description::
      Itemize:::
      Enumerate:::
      Description:::
      . Description
      Itemize::
      * Itemize
      ** Itemize
      ** Enumerate
      ** Description
      * Enumerate
      .. Itemize
      .. Enumerate
      .. Description
      * Description
      Itemize:::
      Enumerate:::
      Description:::
      Enumerate::
      .. Itemize
      * Itemize
      * Enumerate
      * Description
      .. Enumerate
      ... Itemize
      ... Enumerate
      ... Description
      .. Description
      Itemize:::
      Enumerate:::
      Description:::
      Description::
      Itemize:::
      * Itemize
      * Enumerate
      * Description
      Enumerate:::
      .. Itemize
      .. Enumerate
      .. Description
      Description:::
      Itemize::::
      Enumerate::::
      Description::::

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{enumerate}
          \item Itemize
            \begin{itemize}
              \item Itemize
                \begin{itemize}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{itemize}
              \item Enumerate
                \begin{enumerate}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{enumerate}
              \item Description
                \begin{description}
                  \item[Itemize]
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item[Enumerate]
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item[Description]
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{description}
            \end{itemize}
          \item Enumerate
            \begin{enumerate}
              \item Itemize
                \begin{itemize}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{itemize}
              \item Enumerate
                \begin{enumerate}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{enumerate}
              \item Description
                \begin{description}
                  \item[Itemize]
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item[Enumerate]
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item[Description]
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{description}
            \end{enumerate}
          \item Description
            \begin{description}
              \item[Itemize]
                \begin{itemize}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{itemize}
              \item[Enumerate]
                \begin{enumerate}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{enumerate}
              \item[Description]
                \begin{description}
                  \item[Itemize]
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item[Enumerate]
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item[Description]
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{description}
            \end{description}
        \end{enumerate}
      \end{document}
    INPUT
  end

  def test_description_to_level_4
    assert_equal <<~'OUTPUT', render_string(<<~'INPUT')
      Itemize::
      * Itemize
      ** Itemize
      *** Itemize
      *** Enumerate
      *** Description
      ** Enumerate
      . Itemize
      . Enumerate
      . Description
      ** Description
      Itemize:::
      Enumerate:::
      Description:::
      * Enumerate
      . Itemize
      ** Itemize
      ** Enumerate
      ** Description
      . Enumerate
      .. Itemize
      .. Enumerate
      .. Description
      . Description
      Itemize:::
      Enumerate:::
      Description:::
      * Description
      Itemize:::
      ** Itemize
      ** Enumerate
      ** Description
      Enumerate:::
      . Itemize
      . Enumerate
      . Description
      Description:::
      Itemize::::
      Enumerate::::
      Description::::
      Enumerate::
      . Itemize
      * Itemize
      ** Itemize
      ** Enumerate
      ** Description
      * Enumerate
      .. Itemize
      .. Enumerate
      .. Description
      * Description
      Itemize:::
      Enumerate:::
      Description:::
      . Enumerate
      .. Itemize
      * Itemize
      * Enumerate
      * Description
      .. Enumerate
      ... Itemize
      ... Enumerate
      ... Description
      .. Description
      Itemize:::
      Enumerate:::
      Description:::
      . Description
      Itemize:::
      * Itemize
      * Enumerate
      * Description
      Enumerate:::
      .. Itemize
      .. Enumerate
      .. Description
      Description:::
      Itemize::::
      Enumerate::::
      Description::::
      Description::
      Itemize:::
      * Itemize
      ** Itemize
      ** Enumerate
      ** Description
      * Enumerate
      . Itemize
      . Enumerate
      . Description
      * Description
      Itemize::::
      Enumerate::::
      Description::::
      Enumerate:::
      . Itemize
      * Itemize
      * Enumerate
      * Description
      . Enumerate
      .. Itemize
      .. Enumerate
      .. Description
      . Description
      Itemize::::
      Enumerate::::
      Description::::
      Description:::
      Itemize::::
      * Itemize
      * Enumerate
      * Description
      Enumerate::::
      . Itemize
      . Enumerate
      . Description
      Description::::
      Itemize:::::
      Enumerate:::::
      Description:::::

    OUTPUT
      \documentclass{metanorma}
      \begin{document}
        \begin{description}
          \item [Itemize]
            \begin{itemize}
              \item Itemize
                \begin{itemize}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{itemize}
              \item Enumerate
                \begin{enumerate}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{enumerate}
              \item Description
                \begin{description}
                  \item[Itemize]
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item[Enumerate]
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item[Description]
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{description}
            \end{itemize}
          \item [Enumerate]
            \begin{enumerate}
              \item Itemize
                \begin{itemize}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{itemize}
              \item Enumerate
                \begin{enumerate}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{enumerate}
              \item Description
                \begin{description}
                  \item[Itemize]
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item[Enumerate]
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item[Description]
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{description}
            \end{enumerate}
          \item [Description]
            \begin{description}
              \item[Itemize]
                \begin{itemize}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{itemize}
              \item[Enumerate]
                \begin{enumerate}
                  \item Itemize
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item Enumerate
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item Description
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{enumerate}
              \item[Description]
                \begin{description}
                  \item[Itemize]
                    \begin{itemize}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{itemize}
                  \item[Enumerate]
                    \begin{enumerate}
                      \item Itemize
                      \item Enumerate
                      \item Description
                    \end{enumerate}
                  \item[Description]
                    \begin{description}
                      \item[Itemize]
                      \item[Enumerate]
                      \item[Description]
                    \end{description}
                \end{description}
            \end{description}
        \end{description}
      \end{document}
    INPUT
  end
end
