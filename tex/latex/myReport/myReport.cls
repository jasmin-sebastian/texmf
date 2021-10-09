%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%									KLASSE FÜR BERICHTE										%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myReport}[2019/03/03 LaTeX Klasse für Berichte]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%									OPTIONEN DEKLARIEREN									%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------------------------------------------------------------------------
%		Optionen über String
%----------------------------------------------------------------------------------------------
\RequirePackage{kvoptions}									%Stringoption
\DeclareStringOption[12pt]{fntsize}							%Standardschriftgröße
\ProcessKeyvalOptions{myReport}\relax

%----------------------------------------------------------------------------------------------
%		Optionen über Kondition
%----------------------------------------------------------------------------------------------
\newif\if@useEnglish\@useEnglishfalse
\DeclareOption{english}{\@useEnglishtrue}					%Option Englisch

\newif\if@useTwocolumn\@useTwocolumnfalse
\DeclareOption{twocolumn}{\OptionNotUsed\@useTwocolumntrue}	%Option Zweispaltig

\DeclareOption{twoside}{\OptionNotUsed}						%Option Zweiseitig nicht benutzen

%----------------------------------------------------------------------------------------------
%		Optionen übergeben
%----------------------------------------------------------------------------------------------
\PassOptionsToClass{\myReport@fntsize}{scrartcl}			%Standardschriftgröße übergeben
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}%alle Optionen könnnen übergeben werden
\ProcessOptions\relax

%----------------------------------------------------------------------------------------------
%		Klasse mit Optionen laden
%----------------------------------------------------------------------------------------------
\LoadClass[a4paper,parskip=half]{scrartcl}

\KOMAoptions{headinclude}									%Komaoptionen hier
\recalctypearea												%Typearea von Headerpaket benutzt

%----------------------------------------------------------------------------------------------
%		Einstellungen an Begin und Ende des Dokuments
%----------------------------------------------------------------------------------------------
\title{<TITEL>}\author{<AUTHOR>}							%Für \maketitle notwendig
\RequirePackage{etoolbox}									%AfterEndPreamble
\RequirePackage[ngerman,main=english]{babel}				%Standardsprache English

\if@useTwocolumn
	\AfterEndPreamble{\twocolumn[{\begin{@twocolumnfalse}\maketitle\theshort\vspace{\baselineskip}\end{@twocolumnfalse}}]}
\else
	\AfterEndPreamble{\maketitle\theshort}
\fi

\if@useEnglish
	\AtBeginDocument{\Header\hypersetup{pdfinfo={Author={\theauthor},Title={\thetitle}}}\justify}
\else
	\AtBeginDocument{\Header\hypersetup{pdfinfo={Author={\theauthor},Title={\thetitle}}}\justify\selectlanguage{ngerman}}
\fi

\AtEndDocument{\newpage\HeaderRef\printbibliography[heading=bibintoc]}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%										PAKETE LADEN										%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------------------------------------------------------------------------
%		Pakete für Standarteingabe
%----------------------------------------------------------------------------------------------
\RequirePackage[utf8]{inputenc}								%Kodierung (Umlaute)
\RequirePackage[T1]{fontenc}								%Kodierung (z.B. >/<)
\RequirePackage{microtype}									%Mikrotypografiekorrekturen

%----------------------------------------------------------------------------------------------
%		Allgemeine Pakete
%----------------------------------------------------------------------------------------------
\RequirePackage{amsthm,amsmath,amssymb,amsopn,mathtools,bbm}%Mathepakete
\RequirePackage{multirow,array,longtable,booktabs}			%Tabellenpakete (z.B. neue Typen)
\RequirePackage[bible]{blindtext}							%Testen

%----------------------------------------------------------------------------------------------
%		Pakete für Layoutveränderungen
%----------------------------------------------------------------------------------------------
\RequirePackage{scrlayer-scrpage}							%Header
\RequirePackage{enumitem}									%Itemizelayout
\RequirePackage{multicol}									%Mehrere Spalten
\RequirePackage{hyperref}									%Linkhervorhebung
\RequirePackage[normalem]{ulem}								%Unterstreichung gestrichelt, emph normal
\RequirePackage{soulutf8}									%Unterstreichung Abstand, Zeilenumbruch

%----------------------------------------------------------------------------------------------
%		Packages für Literatur
%----------------------------------------------------------------------------------------------
\RequirePackage[autostyle=true,german=quotes]{csquotes}
\RequirePackage[backend=biber,style=alphabetic]{biblatex}

%----------------------------------------------------------------------------------------------
%		Pakete für Design, Zeichnungen
%----------------------------------------------------------------------------------------------
\RequirePackage{graphicx}									%Bilder einfügen
\RequirePackage{float}										%Bilder an bestimmter Stelle
\RequirePackage{xcolor}										%Farbe
\RequirePackage{tikz,tikz-qtree,tikz-cd,pgfplots}			%Bäume, kommutative Diagramme, ER-Diagramme, etc.
\RequirePackage{listings}									%Source Code


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%										EINSTELLUNGEN										%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------------------------------------------------------------------------
%		Allgemeines Layout
%----------------------------------------------------------------------------------------------
\hypersetup{colorlinks=true,linkcolor=black,urlcolor=blue}	%Links
\setlength{\columnsep}{1.5em}								%Spaltenabstand bei twocolumn
\setlist[itemize,2]{label=\pfeil}							%Listenlayout
\setlist[itemize,3]{label=$\rightarrow$}
\setlist[enumerate,3]{label=(\roman*)}

%----------------------------------------------------------------------------------------------
%		Matheeinstellungen
%----------------------------------------------------------------------------------------------
%neue Matheumgebungen
\newtheorem{mydef}{Definition}[section]
\newtheorem*{mydef*}{Definition}
\newtheorem{satz}[mydef]{Satz}
\newtheorem*{satz*}{Satz}
\newtheorem{lemma}[mydef]{Lemma}
\newtheorem*{lemma*}{Lemma}
\newtheorem{bsp}[mydef]{Beispiel}
\newtheorem*{bsp*}{Beispiel}

\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\C}{\mathbb{C}}
\newcommand{\F}{\mathcal{F}}
\renewcommand{\P}{\mathbb{P}}
\newcommand{\one}{\mathbbm{1}}
\DeclareMathOperator{\argmax}{argmax}
\DeclareMathOperator{\argmin}{argmin}
\newcommand{\equnder}[2]{\underset{\underset{#2}{\shortparallel}}{#1}}

%----------------------------------------------------------------------------------------------
%		Layout Source Code/Tikz
%----------------------------------------------------------------------------------------------
\lstset{backgroundcolor=\color{black!5},
	frame=single,
	rulecolor=\color{black},
	numbers=left,
	escapeinside={(/*}{*/)},
	basicstyle=\footnotesize\ttfamily,
	keywordstyle=\color{blue}\bfseries,
	stringstyle=\color{black!10!magenta},
	commentstyle=\color{black!40!green!90}\itshape,
	numberblanklines=false,
	extendedchars=true,
	breaklines=true,
	showspaces=false,
	showstringspaces=false,
	tabsize=2}
\lstset{literate={Ö}{{\"O}}1{Ä}{{\"A}}1{Ü}{{\"U}}1{ß}{{\ss}}1{ü}{{\"u}}1{ä}{{\"a}}1{ö}{{\"o}}1}

\usetikzlibrary{shapes,									%Weitere Knotenformen (z.B. Ellipse)
	shadows,											%Schattierung
	positioning,										%Position (z.B. right of)
	intersections,										%z.B. path
	arrows,												%Pfeile
	automata}											%Automaten (Start-/Endzustände)

%----------------------------------------------------------------------------------------------
%		Neue Spaltentypen
%----------------------------------------------------------------------------------------------
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}%Linksbündige Spalte mit fester Breite
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}%Rechtsbündige Spalte mit fester Breite
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}	%Zentrierte Spalte mit fester Breite
\newcolumntype{M}{>{$}l<{$}}							%Spalte im Mathemodus


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%										NEUE BEFEHLE										%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------------------------------------------------------------------------
%		Einstellungen
%----------------------------------------------------------------------------------------------
\newcommand{\pfeil}{\rotatebox[origin=c]{180}{$\Lsh$}}	%Pfeil für Aufzählung
\newcommand{\nix}{$\phantom{a}$}						%Unsichtbares Zeichen

\setuldepth{a}\setlength{\ULdepth}{0.25ex}				%Unterstrichbstand minimieren
\renewcommand{\uline}[1]{\ul{#1}}						%Backwardscompatibility

\newcommand{\numberthis}{\addtocounter{equation}{1}\tag %Nummerierung bei align*-Umgebung
	{\theequation}}
\newcommand*{\justify}{\fontdimen2\font=0.4em			%Automatische Zeilenumbrüche
	\fontdimen3\font=0.2em\fontdimen4\font=0.1em\fontdimen7\font=0.1em\hyphenchar\font=`\-}

%----------------------------------------------------------------------------------------------
%		Abkürzungen
%----------------------------------------------------------------------------------------------
\newcommand{\ra}{$\rightarrow$\,}						%Abkürzung Pfeil einfach
\newcommand{\Ra}{$\Rightarrow$\,}						%Abkürzung Pfeil doppelt


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%										VARIABELN											%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
%----------------------------------------------------------------------------------------------
%		Titel
%----------------------------------------------------------------------------------------------
\gdef\thetitle{<TITLE>}
\let\orig@title=\title
\renewcommand{\title}[1]{\gdef\thetitle{#1}\orig@title{#1}}

%----------------------------------------------------------------------------------------------
%		Autor
%----------------------------------------------------------------------------------------------
\gdef\theauthor{<AUTHOR>}
\let\orig@author=\author
\renewcommand{\author}[1]{\gdef\theauthor{#1}\orig@author{#1}}

%----------------------------------------------------------------------------------------------
%		Linker Header
%----------------------------------------------------------------------------------------------
\gdef\thelhead{}										%Header für plain.scrheadings
\newcommand{\lhead}[1]{\gdef\thelhead{#1}}

%----------------------------------------------------------------------------------------------
%		Rechter Header
%----------------------------------------------------------------------------------------------
\gdef\therhead{}										%Header für plain.scrheadings
\newcommand{\rhead}[1]{\gdef\therhead{#1}}

%----------------------------------------------------------------------------------------------
%		Abstract
%----------------------------------------------------------------------------------------------
\gdef\theshort{											%Abstract in Umgebung
	\begin{abstract}\small
		Enter abstract (with command \texttt{$\backslash$short}) \dots
	\end{abstract}
}
\newcommand{\short}[1]{\gdef\theshort{
	\begin{abstract}\small
		#1
	\end{abstract}
}}

\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%										HEADER												%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\Header}{										%Für Mainmatter
	\lohead[\thelhead]{\thetitle}							%Titel in Header (plain optional)
	\rohead[\therhead]{\theauthor}							%Autor in Header (plain optional)
}

\newcommand{\HeaderRef}{									%Für Literaturverzeichnis
	\thispagestyle{empty}									%Erste Seite ohne Header
	\clearscrheadfoot
	\pagenumbering{roman}									%Römische Nummerierung
	\automark{section}										%Lebende Kolumnentitel
	\lohead{\headmark}										%Kapitelname im Header
	\rohead{\pagemark}										%Seitzahl in Header
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\endinput

