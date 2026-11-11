\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gak-article}[2026/11/11 GAK Article Template]

%% KOMA options
\LoadClass{scrartcl}

\KOMAoptions{numbers=endperiod}
\setkomafont{disposition}{\bfseries}
\setkomafont{title}{\normalfont\Huge}
\setkomafont{section}{\centering\normalfont\scshape\large}

%% Font stuff

\RequirePackage[T1]{fontenc}
\RequirePackage{mlmodern}
\renewcommand{\bfdefault}{b}
% \RequirePackage[adobe-utopia]{mathdesign}
\RequirePackage{microtype}

%% Various nice packages 

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage[svgnames]{xcolor}
\RequirePackage{wasysym}
\RequirePackage{stmaryrd}
\RequirePackage{fontawesome}
\RequirePackage{jmsdelim}
\RequirePackage{mathtools}
\RequirePackage{tikz}

% Since the 2024-11-01 kernel, \@addtoreset{ctr}{parent} also defines
% \theHctr as \theHparent.\the\value{ctr}, and hyperref no longer patches it.
% thmtools' aliasctr.sty overwrites \@addtoreset without that step, so a
% theorem counter reset by section gets unqualified hyperref anchors, which
% collide across sections. Restore it on top of aliasctr's version.
\AddToHook{package/aliasctr/after}{%
  \let\gak@aliasctr@addtoreset\@addtoreset
  \renewcommand*\@addtoreset[2]{%
    \gak@aliasctr@addtoreset{#1}{#2}%
    \expandafter\xdef\csname theH#1\endcsname{%
      \expandafter\noexpand\csname theH#2\endcsname.%
      \noexpand\the\noexpand\value{#1}}%
  }%
}
\RequirePackage{thmtools}

\RequirePackage[pdfusetitle,hyperfootnotes=false]{hyperref}
\RequirePackage[capitalize,nameinlink]{cleveref}

%% Cleverref options

\crefname{equation}{}{}
\crefname{section}{\S\!\!}{\S\!\!}
% Create counter for diagrams
\newcounter{diagram}
% Create diagram environment
\newenvironment{diagram}[1][]{%
    \begin{equation}%
    \begin{tikzpicture}[#1, baseline=(current  bounding  box.center)]%
    \setcounter{diagram}{\theequation}
    \addtocounter{diagram}{-1}
    \refstepcounter{diagram}
}{%
    \end{tikzpicture}%
    \end{equation}%
}
\crefname{diagram}{Diagram}{Diagrams}

%% Make description and labelling environments nicer
\setkomafont{descriptionlabel}{\normalfont\bfseries}
\setkomafont{labelinglabel}{\normalfont\bfseries}
\setkomafont{labelingseparator}{\normalfont}

%% AMS Theorem options

\theoremstyle{definition}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{conjecture}[theorem]{Conjecture}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{rul}[theorem]{Rule}

\newtheorem{definition}[theorem]{Definition}
\newtheorem{notation}[theorem]{Notation}
\newtheorem{construction}[theorem]{Construction}

%% With longer examples and remarks, it's nice to have an end clearly defined, particularly when
%% there's a page break involved.
\newtheorem{examplex}[theorem]{Example}
\newenvironment{example}
  {\pushQED{\qed}\renewcommand{\qedsymbol}{$\lhd$}\examplex}
  {\popQED\endexamplex}
\newtheorem{remarkx}[theorem]{Remark}
\newenvironment{remark}
  {\pushQED{\qed}\renewcommand{\qedsymbol}{$\lhd$}\remarkx}
  {\popQED\endremarkx}

\theoremstyle{remark}
\newtheorem{assumption}[theorem]{Assumption}
\newtheorem{convention}[theorem]{Convention}


%% From https://tex.stackexchange.com/questions/42726/align-but-show-one-equation-number-at-the-end
\NewDocumentCommand{\TagEq}{o}{\IfValueTF{#1}{\tag{#1}}{\stepcounter{equation}\tag{\theequation}}}

\allowdisplaybreaks%
