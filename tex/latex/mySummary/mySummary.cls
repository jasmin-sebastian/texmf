%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%									KLASSE FÜR BERICHTE										%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mySummary}[2019/03/03 LaTeX Klasse für Zusammenfassungen]


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
\ProcessKeyvalOptions{mySummary}\relax

%----------------------------------------------------------------------------------------------
%		Optionen über Kondition
%----------------------------------------------------------------------------------------------
\newif\if@useEnglish\@useEnglishfalse
\DeclareOption{english}{\@useEnglishtrue}					%Option Englisch

\DeclareOption{twoside}{\OptionNotUsed}						%Option Zweiseitig nicht benutzen

%----------------------------------------------------------------------------------------------
%		Optionen übergeben
%----------------------------------------------------------------------------------------------
\PassOptionsToClass{\mySummary@fntsize}{scrartcl}			%Standardschriftgröße übergeben
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}%alle Optionen könnnen übergeben werden
\ProcessOptions\relax

%----------------------------------------------------------------------------------------------
%		Klasse mit Optionen laden
%----------------------------------------------------------------------------------------------
\LoadClass[a4paper,parskip=half]{scrartcl}

\KOMAoptions{headinclude}									%Komaoptionen hier
\recalctypearea												%Typearea von Headerpaket benutzt

%----------------------------------------------------------------------------------------------
%		Einstellungen am Begin des Dokuments (Sprache)
%----------------------------------------------------------------------------------------------
\RequirePackage[ngerman,main=english]{babel}				%Standardsprache English

\if@useEnglish
	\AtBeginDocument{\hypersetup{pdfinfo={Author={\theauthor},Title={\thetitle\, \thesubtitle}}}\justify}
\else
	\AtBeginDocument{\hypersetup{pdfinfo={Author={\theauthor},Title={\thetitle\, \thesubtitle}}}\justify\selectlanguage{ngerman}}
\fi


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
\RequirePackage[headsepline]{scrlayer-scrpage}				%Header
\RequirePackage{enumitem}									%Itemizelayout
\RequirePackage{multicol}									%Mehrere Spalten
\RequirePackage{hyperref}									%Linkhervorhebung
\RequirePackage[normalem]{ulem}								%Unterstreichung gestrichelt, emph normal
\RequirePackage{soulutf8}									%Unterstreichung Abstand, Zeilenumbruch
\RequirePackage[autostyle=true,german=quotes]{csquotes}		%Anführungszeichen

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
%		Untertitel
%----------------------------------------------------------------------------------------------
\gdef\thesubtitle{}
\let\orig@subtitle=\subtitle
\renewcommand{\subtitle}[1]{\gdef\thesubtitle{- #1}\orig@subtitle{#1}}

%----------------------------------------------------------------------------------------------
%		Autor
%----------------------------------------------------------------------------------------------
\gdef\theauthor{<AUTHOR>}
\let\orig@author=\author
\renewcommand{\author}[1]{\gdef\theauthor{#1}\orig@author{#1}}

%----------------------------------------------------------------------------------------------
%		Semester
%----------------------------------------------------------------------------------------------
\gdef\theterm{}
\newcommand{\term}[1]{\gdef\theterm{#1}}

\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%										HEADER												%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\clearscrheadfoot
\lohead{\thetitle\, \theterm\, \thesubtitle}			%Titel und Semester
\rohead{\pagemark}										%Seitzahl in Header


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\endinput

