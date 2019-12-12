%
% tex2mn 0.3.0 - converts Metanorma documents from LaTeX to AsciiDoc
%
% Copyright (C) 2019 Ribose Inc. <open.source@ribose.com>
% This project is available under the terms of the MIT License.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Metanorma}
   [2019/07/07 Metanorma]

\LoadClass{article}

\RequirePackage{graphicx}
\RequirePackage{hyperref}
% TODO: what's the best baseline AMS setup?
\RequirePackage{amsmath}
\RequirePackage{subcaption}
\RequirePackage{enumitem}

\RequirePackage{xparse}

%% RDF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \RequirePackage{lxRDFa}
% Let's not introduce another (mostly trivial) dependency, and just embed it:
\DeclareRobustCommand{\lxRDFa}[2][]{}
\DeclareRobustCommand{\lxRDF}[2][]{}

\NewDocumentCommand{\mn}{m}
  {\lxRDF[#1]{property=mn:attributes}}

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

\mdfdefinestyle{mnbase}{
  frametitlerule=true,
  frametitlefont=\sffamily\bfseries\scshape\small,
  linecolor=gray,
}

% Admonitions

\mdfdefinestyle{note}{linecolor=blue,frametitle=Note}
\mdfdefinestyle{tip}{linecolor=green,frametitle=Tip}
\mdfdefinestyle{important}{linecolor=yellow,frametitle=Important}
\mdfdefinestyle{caution}{linecolor=red,frametitle=Caution}
\mdfdefinestyle{warning}{linecolor=orange,frametitle=Warning}

\newmdenv[style=mnbase,style=note]{note}
\newmdenv[style=mnbase,style=tip]{tip}
\newmdenv[style=mnbase,style=important]{important}
\newmdenv[style=mnbase,style=caution]{caution}
\newmdenv[style=mnbase,style=warning]{warning}

% Requirement, recommendation and permission

\mdfdefinestyle{requirement}{linecolor=gray,frametitle=Requirement}
\mdfdefinestyle{recommendation}{linecolor=gray,frametitle=Recommendation}
\mdfdefinestyle{permission}{linecolor=gray,frametitle=Permission}

\newmdenv[style=mnbase,style=requirement]{requirement}
\newmdenv[style=mnbase,style=recommendation]{recommendation}
\newmdenv[style=mnbase,style=permission]{permission}

% Specification, measurement target, verification and import

\mdfdefinestyle{specification}{linecolor=lightgray,frametitle=Specification}
\mdfdefinestyle{measurement-target}{linecolor=lightgray,frametitle=Measurement target}
\mdfdefinestyle{verification}{linecolor=lightgray,frametitle=Verification}
\mdfdefinestyle{import}{linecolor=lightgray,frametitle=Import}

\newmdenv[style=mnbase,style=specification]{specification}
\newmdenv[style=mnbase,style=measurement-target]{measurement-target}
\newmdenv[style=mnbase,style=verification]{verification}
\newmdenv[style=mnbase,style=import]{import}

%% Terms and definitions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewDocumentCommand{\alt}{m}{{\large #1}\par}
\NewDocumentCommand{\deprecated}{m}{\textbf{DEPRECATED:} #1\par}
\NewDocumentCommand{\domain}{m}{\textbf{DOMAIN:} #1\par}

\mdfdefinestyle{example}{linecolor=lightgray,frametitle=Example}
\mdfdefinestyle{source}{linecolor=lightgray,frametitle=Source}

\newmdenv[style=mnbase,style=example]{example}
\newmdenv[style=mnbase,style=source]{source}

%% Citation macros %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TODO: handle localities formatting
\NewDocumentCommand{\mncite}{omo}{\cite[#1]{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlist{key}{description}{1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
