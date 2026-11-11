% The 2026-06-01 kernel gives sibling theorems their own alias counters, so
% that a lemma is referred to as a lemma rather than a theorem.
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
\RequirePackage{zref-clever}

%% Cross-references: \zcref{...}

\zcsetup{cap, nameinlink=true}
\zcRefTypeSetup{section}{
  Name-sg = \S, name-sg = \S, Name-pl = \S, name-pl = \S, namesep = {},
}
\zcRefTypeSetup{equation}{
  Name-sg = {}, name-sg = {}, Name-pl = {}, name-pl = {}, namesep = {},
}

% A displayed, numbered TikZ picture, referred to as a diagram.
\newenvironment{diagram}[1][]{%
    \begin{equation}%
    \zcsetup{reftype = diagram}%
    \begin{tikzpicture}[#1, baseline=(current  bounding  box.center)]%
}{%
    \end{tikzpicture}%
    \end{equation}%
}
\zcRefTypeSetup{diagram}{
  Name-sg = Diagram, name-sg = diagram, Name-pl = Diagrams, name-pl = diagrams,
}

%% Make description and labelling environments nicer
\setkomafont{descriptionlabel}{\normalfont\bfseries}
\setkomafont{labelinglabel}{\normalfont\bfseries}
\setkomafont{labelingseparator}{\normalfont}

%% AMS Theorem options

% Theorems are numbered within this counter.
\newcommand*{\gak@theoremwithin}{section}

\theoremstyle{definition}
\newtheorem{theorem}{Theorem}[\gak@theoremwithin]
\zcRefTypeSetup{theorem}{Name-sg = Theorem, Name-pl = Theorems}

% \gak@newsibling{env}{Name}{Names} declares a theorem-like environment numbered
% with theorem. Its counter is a kernel alias of theorem's, which zref-clever
% does not know to be reset with theorem's.
\NewDocumentCommand{\gak@newsibling}{mmm}{%
  \newtheorem{#1}[theorem]{#2}%
  \zcsetup{counterresetby = {#1 = \gak@theoremwithin}}%
  \zcRefTypeSetup{#1}{Name-sg = #2, Name-pl = #3}%
}

\gak@newsibling{lemma}{Lemma}{Lemmas}
\gak@newsibling{conjecture}{Conjecture}{Conjectures}
\gak@newsibling{proposition}{Proposition}{Propositions}
\gak@newsibling{corollary}{Corollary}{Corollaries}
\gak@newsibling{rul}{Rule}{Rules}

\gak@newsibling{definition}{Definition}{Definitions}
\gak@newsibling{notation}{Notation}{Notations}
\gak@newsibling{construction}{Construction}{Constructions}

%% With longer examples and remarks, it's nice to have an end clearly defined, particularly when
%% there's a page break involved.
\gak@newsibling{examplex}{Example}{Examples}
\newenvironment{example}
  {\pushQED{\qed}\renewcommand{\qedsymbol}{$\lhd$}\examplex}
  {\popQED\endexamplex}
\gak@newsibling{remarkx}{Remark}{Remarks}
\newenvironment{remark}
  {\pushQED{\qed}\renewcommand{\qedsymbol}{$\lhd$}\remarkx}
  {\popQED\endremarkx}

\theoremstyle{remark}
\gak@newsibling{assumption}{Assumption}{Assumptions}
\gak@newsibling{convention}{Convention}{Conventions}


%% From https://tex.stackexchange.com/questions/42726/align-but-show-one-equation-number-at-the-end
\NewDocumentCommand{\TagEq}{o}{\IfValueTF{#1}{\tag{#1}}{\stepcounter{equation}\tag{\theequation}}}

\allowdisplaybreaks%
