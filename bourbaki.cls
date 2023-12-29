%% Some customizations to the book or article class, to make it resemble
%% Bourbaki's books.
%%
%% I am assuming you are writing a book. If you want to write a chapter
%% in a book, then you should use the [chapter] or [article] option. The
%% \maketitle for [article] and [chapter] options will typeset it as a
%% chapter. 
%%
%% There are only sections and subsections (just like in Bourbaki's books),
%% and all other sectioning commands have been undefined.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bourbaki}[2023/12/28 Bourbaki book class]

\newcounter{article}
% for key-value options
\RequirePackage{xkeyval}

\newif\ifbook\booktrue
\DeclareOption{article}{\bookfalse}
\DeclareOptionX{chapter}{\bookfalse\setcounter{article}{#1}}
\ExecuteOptionsX{chapter=1}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptionsX
\immediate\write16{Chapter number \thearticle}


\ProcessOptions\relax

\ifbook
\LoadClass{book}
\renewcommand\thesection{\arabic{section}}
\renewcommand\thesubsection{\arabic{subsection}}
\else
\LoadClass{article}
\fi

\RequirePackage{amsmath,amssymb,amsthm}

%\edef\mytitle{\@title}
\let\og@title\title
\def\THETITLE{}
\def\title#1{\xdef\THETITLE{#1}\og@title{#1}}
%\AtBeginDocument{\NewCommandCopy{\THETITLE}{\thetitle}}
% header formatting
\usepackage[inner=6pc,outer=6pc]{geometry}
\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[LE]{\Roman{article}}
\fancyhead[CE]{\ifbook\chaptername\else\THETITLE\fi}
\fancyhead[RO]{\S\arabic{section}.\arabic{subsection}}
\fancyhead[CO]{\leftmark}
\fancyfoot{}
\fancyfoot[RO,LE]{\thepage}
% https://tex.stackexchange.com/a/252415
\renewcommand{\subsectionmark}[1]{\markboth{#1}{}} % MAKE IT 'subsectionmark' INSTEAD OF 'sectionmark'
% section formatting
\def\ucbf#1{\MakeUppercase{\bfseries #1}}

\renewcommand\thesubsection{\arabic{subsection}}

\def\section{\@startsection{section}{1}%
  \z@{4pc}{1.5pc}%.7\baselineskip plus\baselineskip}{.5\baselineskip}%
  {\Large\centering\MakeUppercase}}
\def\subsection{\@startsection{subsection}{2}%
  \z@{1.125pc}{0.5pc}%\baselineskip plus.7\baselineskip}{-.5em}%
  {\ucbf}}

% Bourbaki does not have anything "lower" than subsection, so we respect that
\let\subsubsection\undefined
\let\paragraph\undefined
\let\subparagraph\undefined




% Bourbaki's style, as found in, e.g., their Lie Groups book.
\def\th@plain{%
%%  \let\thm@indent\noindent % no indent
%%  \thm@headfont{\bfseries}% heading font is bold
%%  \thm@notefont{}% same as heading font
%%  \thm@headpunct{.}% add period after heading
%%  \let\thm@swap\@gobble
%%  \thm@preskip\topsep
%%  \thm@postskip\theorempreskipamount
  \thm@headfont{\scshape}%
  \itshape % body font
}
\def\th@definition{%
  \thm@headfont{\scshape}%
  \normalfont % body font
}
\def\th@remark{%
  \thm@headfont{\small\itshape}%
  \addtolength{\@totalleftmargin}{2\parindent}
   \addtolength{\linewidth}{-2\parindent}
   \parshape 1 2\parindent \linewidth\small  \normalfont % body font
  \thm@preskip\topsep \divide\thm@preskip\tw@
  \thm@postskip\thm@preskip
}

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}{Corollary}[theorem]
\newtheorem{lemma}[theorem]{Lemma}

\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}

\theoremstyle{remark}
\newtheorem{remark}{Remark}[theorem]
\newtheorem*{remark*}{Remark}
\newtheorem{remarks}{Remarks}[theorem]

\endinput
