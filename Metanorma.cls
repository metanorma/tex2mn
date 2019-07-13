\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Metanorma}
   [2019/07/07 Metanorma]

\LoadClass{article}

\RequirePackage{xparse}
\RequirePackage{lxRDFa}

\NewDocumentCommand{\mn}{m}
  {\lxRDFa[.]{asciidoc-attributes={#1}}}

%% Strikethrough %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% `normalem` avoids changes to the behaviour of emphasis.
\RequirePackage[normalem]{ulem}

% We decouple the class' API from the package choice.
\let\textst\sout
