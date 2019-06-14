\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IsoStandardDocument}
   [2019/06/14 IsoStandardDocument]

\LoadClass{article}

\RequirePackage{xparse}
\RequirePackage{lxRDFa}

\NewDocumentCommand{\Section}{om}
  {\section{#2}\lxRDFa[.]{#1}}
