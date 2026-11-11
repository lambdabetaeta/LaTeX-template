% The 2026-06-01 kernel gives sibling theorems their own alias counters, so
% \cref names a lemma "Lemma" rather than "Theorem" without thmtools.
\NeedsTeXFormat{LaTeX2e}[2026-06-01]
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

\RequirePackage[pdfusetitle,hyperfootnotes=false]{hyperref}
\RequirePackage[capitalize,nameinlink]{cleveref}

% cleveref predates the kernel's alias counters, which \newtheorem{lemma}[theorem]
% now creates. Ask what resets an alias's root counter instead of the alias, so
% that \cref sorts and compresses sibling theorems by section.
\let\gak@cref@resetby\cref@resetby
\def\cref@resetby#1{%
  \edef\gak@ctr@root{\@kernel@get@ctr@root{#1}}%
  \expandafter\gak@cref@resetby\expandafter{\gak@ctr@root}%
}

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
\crefname{examplex}{Example}{Examples}
\crefname{remarkx}{Remark}{Remarks}

\theoremstyle{remark}
\newtheorem{assumption}[theorem]{Assumption}
\newtheorem{convention}[theorem]{Convention}


%% From https://tex.stackexchange.com/questions/42726/align-but-show-one-equation-number-at-the-end
\NewDocumentCommand{\TagEq}{o}{\IfValueTF{#1}{\tag{#1}}{\stepcounter{equation}\tag{\theequation}}}

\allowdisplaybreaks%
