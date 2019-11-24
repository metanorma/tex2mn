%
% tex2mn 0.1.0 - converts Metanorma documents from LaTeX to AsciiDoc
%
% Copyright (C) 2019 Ribose Inc. <open.source@ribose.com>
% This project is available under the terms of the MIT License.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Metanorma}
   [2019/07/07 Metanorma]

\LoadClass{article}

\RequirePackage{lxRDFa}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
% TODO: what's the best baseline AMS setup?
\RequirePackage{amsmath}
\RequirePackage{subcaption}

\RequirePackage{xparse}

\NewDocumentCommand{\mn}{m}
  {\lxRDF{property=asciidoc-attributes,content={#1}}}
\NewDocumentCommand{\mna}{m}
  {\lxRDFa[.]{asciidoc-attributes={#1}}}

%% Document attributes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makeatletter

\NewDocumentCommand{\set}{mm}{%
  \lxRDF{property=#1,content=#2}%
  \expandafter\def\csname metadata@#1\endcsname{#2}}

\@onlypreamble\set

\NewDocumentCommand{\get}{m}
  {\csname metadata@#1\endcsname}

\makeatother

%% General style %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% No indentation on paragraphs.
\setlength\parindent{0pt}

%% Strikethrough %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% `normalem` avoids changes to the behaviour of emphasis.
\RequirePackage[normalem]{ulem}

% We decouple the class' API from the package choice.
\let\textst\sout

%% Blocks %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[framemethod=TikZ]{mdframed}

% Admonitions

\newmdenv[linecolor=blue,frametitle=Note]{note}
\newmdenv[linecolor=green,frametitle=Tip]{tip}
\newmdenv[linecolor=yellow,frametitle=Important]{important}
\newmdenv[linecolor=red,frametitle=Caution]{caution}
\newmdenv[linecolor=orange,frametitle=Warning]{warning}

% Requirement, recommendation and permission

\mdfdefinestyle{requirement}{linecolor=gray,frametitle=Requirement}
\mdfdefinestyle{recommendation}{linecolor=gray,frametitle=Recommendation}
\mdfdefinestyle{permission}{linecolor=gray,frametitle=Permission}

\NewDocumentEnvironment{requirement}{}{\begin{mdframed}[style=requirement]}{\end{mdframed}}
\NewDocumentEnvironment{recommendation}{}{\begin{mdframed}[style=recommendation]}{\end{mdframed}}
\NewDocumentEnvironment{permission}{}{\begin{mdframed}[style=permission]}{\end{mdframed}}

% Specification, measurement target, verification and import

\mdfdefinestyle{specification}{linecolor=lightgray,frametitle=Specification}
\mdfdefinestyle{measurement-target}{linecolor=lightgray,frametitle=Measurement target}
\mdfdefinestyle{verification}{linecolor=lightgray,frametitle=Verification}
\mdfdefinestyle{import}{linecolor=lightgray,frametitle=Import}

\NewDocumentEnvironment{specification}{}{\begin{mdframed}[style=specification]}{\end{mdframed}}
\NewDocumentEnvironment{measurement-target}{}{\begin{mdframed}[style=measurement-target]}{\end{mdframed}}
\NewDocumentEnvironment{verification}{}{\begin{mdframed}[style=verification]}{\end{mdframed}}
\NewDocumentEnvironment{import}{}{\begin{mdframed}[style=import]}{\end{mdframed}}

%% Terms and definitions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewDocumentCommand{\alt}{m}{{\large #1}\par}
\NewDocumentCommand{\deprecated}{m}{\textbf{DEPRECATED:} #1\par}
\NewDocumentCommand{\domain}{m}{\textbf{DOMAIN:} #1\par}

\mdfdefinestyle{example}{linecolor=lightgray,frametitle=Example}
\mdfdefinestyle{source}{linecolor=lightgray,frametitle=Source}

\NewDocumentEnvironment{example}{}{\begin{mdframed}[style=example]}{\end{mdframed}}
\NewDocumentEnvironment{source}{}{\begin{mdframed}[style=source]}{\end{mdframed}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
