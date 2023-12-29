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
%%
%% Options:
%%
%% usebookdim - if you want to use the paper dimensions matching the
%% English published books (about 9.25 inches page height, 6.1 inches
%% page width, 0.75 inner and outer margins)
%%
%% chapter=n - if you want to write a manuscript for a chapter to be
%% included in a book, use this option
%%
%% article - if you want to write a standalone manuscript, use this option
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bourbaki}[2023/12/28 Bourbaki book class]

\newif\ifusebookdim\usebookdimfalse
\newcounter{article}
% for key-value options
\RequirePackage{xkeyval}

\newif\ifleqno\leqnotrue
\newif\ifbook\booktrue
\newif\ifarticle\articlefalse
\newif\ifchapter\chapterfalse
\DeclareOption{reqno}{\leqnofalse}
\DeclareOption{usebookdim}{\usebookdimtrue}
\DeclareOption{article}{\bookfalse\articletrue}
\DeclareOptionX{chapter}{\bookfalse\articletrue\chaptertrue\setcounter{article}{#1}}
%\ExecuteOptionsX{chapter=1}
\DeclareOption*{\ifbook\PassOptionsToClass{\CurrentOption}{book}\else\PassOptionsToClass{\CurrentOption}{article}\fi}
\ProcessOptionsX
\immediate\write16{Chapter number \thearticle}


\ProcessOptions\relax

\ifbook
\immediate\write16{Bourbaki book class loaded}
\LoadClass{book}
\else
\immediate\write16{Article class loaded}
\LoadClass{article}
\fi

\RequirePackage[leqno]{amsmath}
\RequirePackage{amssymb,amsthm}
\def\@seccntformat#1{\csname the#1\endcsname.\quad}

% Define various things which are missing in the article
\def\THETITLE{}
\ifbook
  \renewcommand\thechapter{\Roman{chapter}}
  %\counterwithout{equation}{chapter}
\fi
\ifarticle
  \let\og@title\title
  \gdef\title#1{\xdef\THETITLE{#1}\og@title{#1}}
  \renewcommand\thearticle{\Roman{article}}
  \gdef\chaptermark#1{%
        \markboth {\MakeUppercase{%
              \@chapapp\ \thechapter. \ %
          #1}}{}}
\fi
\renewcommand\thesection{\S\arabic{section}}
\renewcommand\thesubsection{\arabic{subsection}}
\renewcommand\theequation{\arabic{equation}}
% Bourbaki's style numbers equations within each section in his book on
% Set Theory, e.g., chapter III section 1 vs section 7
\@addtoreset{equation}{section}

\ifusebookdim
\usepackage[inner=0.75in,
  outer=0.75in,
  top=1in,
  headsep=2pc,
  bottom=1.25in,
  footskip=2pc,
  paperwidth=6.1in,
  paperheight=9.25in]{geometry}
\fi

\@ifundefined{if@mainmatter}{\newif\if@mainmatter\@mainmattertrue}{}

\def\thesubsectionheader{\thesection.\thesubsection}
\ifbook
\gdef\thearticle{\if@mainmatter\thechapter\fi}
\gdef\THETITLE{\if@mainmatter\leftmark\fi}
\gdef\thesubsectionheader{\if@mainmatter\thesection.\thesubsection\fi}
\fi

% header formatting
%\usepackage[inner=6pc,outer=6pc]{geometry}
\usepackage{fancyhdr}


\fancypagestyle{bourbaki-fancy-style}{%
  \fancyhf{} % sets both header and footer to nothing
  \renewcommand{\headrulewidth}{0pt}
  \pagestyle{fancy}
  \fancyhead{}
  \fancyhead[LE]{\thearticle}
  \fancyhead[CE]{\small\MakeUppercase{\THETITLE}}
  \fancyhead[RO]{\thesubsectionheader}
  %% \fancyhead[LE]{\ifbook{\if@mainmatter\thechapter\fi}\else\thearticle\fi}
  %% \fancyhead[CE]{\ifbook{\if@mainmatter\leftmark\fi}\else\THETITLE\fi}
  %% \fancyhead[RO]{\ifbook{\if@mainmatter\thesection.\thesubsection\fi}\else\thesection.\thesubsection\fi}
  \fancyhead[CO]{\small\MakeUppercase{\rightmark}}
  \fancyfoot{}
  \fancyfoot[RO,LE]{\thepage}
}
% Redefine the plain page style
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[RO,LE]{\thepage}%
  \renewcommand{\headrulewidth}{0pt}% Line at the header invisible
}
\pagestyle{bourbaki-fancy-style}


% https://tex.stackexchange.com/a/252415
\renewcommand{\subsectionmark}[1]{\markright{#1}}
\renewcommand\chaptermark[1]{\markboth{#1}{}}

% section formatting

\def\section{\@startsection{section}{1}%
  \z@{4pc}{1.5pc}%.7\baselineskip plus\baselineskip}{.5\baselineskip}%
  {\Large\centering\MakeUppercase}}
\def\subsection{\@startsection{subsection}{2}%
  \z@{1.125pc}{0.5pc}%\baselineskip plus.7\baselineskip}{-.5em}%
  {\bfseries\MakeUppercase}}

% Bourbaki does not have anything "lower" than subsection, so we respect that
\let\subsubsection\undefined
\let\paragraph\undefined
\let\subparagraph\undefined

\ifbook
\def\@makechapterhead#1{%
  \vspace*{12\p@}% <----------------- Space from top of page to Chapter #
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \centering{\small\MakeUppercase{\@chapapp\space \thechapter}}% <-- Chapter #
        \par\nobreak
        \vskip 20\p@% <-------------- Space between Chapter # and title
    \fi
    \interlinepenalty\@M
    \Huge \bfseries #1\par\nobreak% <------------------ Chapter title
    \vskip 40\p@% <------------------ Space between chapter title and first paragraph
  }}
% For articles, format it like the chapter
\else\ifchapter
\def\maketitle{\thispagestyle{plain}
  \vspace*{12\p@}% <----------------- Space from top of page to Chapter #
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \centering{\small\MakeUppercase{Chapter\space \thearticle}}% <-- Chapter #
        \par\nobreak
        \vskip 20\p@% <-------------- Space between Chapter # and title
    \fi
    \interlinepenalty\@M
    {\Huge \bfseries \@title\par\nobreak}% <------------------ Chapter title
    \ifx\@author\@empty
    \vskip 40\p@% <------------------ Space between chapter title and first paragraph
    \else
    \vskip 20\p@
    \centering\normalfont by \@author\par
    \vskip 20\p@
    \fi
  }
}
\fi\fi


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

\renewcommand\thetheorem{\arabic{section}.\arabic{theorem}}



\endinput
