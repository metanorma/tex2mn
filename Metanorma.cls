\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Metanorma}
   [2019/07/07 Metanorma]

\LoadClass{article}

\RequirePackage{lxRDFa}
\RequirePackage{graphicx}

\RequirePackage{xparse}

\NewDocumentCommand{\mn}{m}
  {\lxRDFa[.]{asciidoc-attributes={#1}}}

%% General style %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% No indentation on paragraphs.
\setlength\parindent{0pt}

%% Strikethrough %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% `normalem` avoids changes to the behaviour of emphasis.
\RequirePackage[normalem]{ulem}

% We decouple the class' API from the package choice.
\let\textst\sout

%% Admonitions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NOTE: we could use any other package, actually.

\RequirePackage[framemethod=TikZ]{mdframed}
\newmdenv[linecolor=blue,frametitle=Note]{note}
\newmdenv[linecolor=green,frametitle=Tip]{tip}
\newmdenv[linecolor=yellow,frametitle=Important]{important}
\newmdenv[linecolor=red,frametitle=Caution]{caution}
\newmdenv[linecolor=orange,frametitle=Warning]{warning}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
