\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Metanorma}
   [2019/07/07 Metanorma]

\LoadClass{article}

\RequirePackage{xparse}
\RequirePackage{lxRDFa}

\NewDocumentCommand{\mn}{m}
  {\lxRDFa[.]{asciidoc-attributes={#1}}}
