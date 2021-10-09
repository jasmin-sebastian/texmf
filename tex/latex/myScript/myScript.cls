%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%									KLASSE FÜR SKRIPTE										%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myScript}[2019/02/26 LaTeX Klasse für Skripte]


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
\ProcessKeyvalOptions{myScript}\relax

%----------------------------------------------------------------------------------------------
%		Optionen über Kondition
%----------------------------------------------------------------------------------------------
\newif\if@useLongtitle\@useLongtitlefalse
\DeclareOption{longtitle}{\@useLongtitletrue}				%Option langer Titel

\newif\if@useEnglish\@useEnglishfalse
\DeclareOption{english}{\@useEnglishtrue}					%Option Englisch

%----------------------------------------------------------------------------------------------
%		Optionen übergeben
%----------------------------------------------------------------------------------------------
\PassOptionsToClass{\myScript@fntsize}{scrbook}				%Standardschriftgröße übergeben
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}%alle Optionen könnnen übergeben werden
\ProcessOptions\relax

%----------------------------------------------------------------------------------------------
%		Klasse mit Optionen laden
%----------------------------------------------------------------------------------------------
\LoadClass[a4paper,parskip=half,oneside]{scrbook}

\KOMAoptions{headinclude}									%Komaoptionen hier
\recalctypearea												%Typearea von Headerpaket benutzt

%----------------------------------------------------------------------------------------------
%		Einstellungen an Begin und Ende des Dokuments (z.B. Sprache)
%----------------------------------------------------------------------------------------------
\RequirePackage{etoolbox}									%AfterEndPreamble, patchcmd
\RequirePackage[ngerman,main=english]{babel}				%Standardsprache English

\if@useLongtitle
	\AfterEndPreamble{\tpLang\frontmatter\tableofcontents\mainmatter}
\else
	\AfterEndPreamble{\tpKurz\frontmatter\tableofcontents\mainmatter}
\fi

\makeatletter												%Römische Nummerierung in backmatter
\patchcmd{\backmatter}{\@mainmatterfalse}
{\@mainmatterfalse\pagenumbering{roman}}{}{}
\makeatother

\if@useEnglish
	\AtBeginDocument{\hypersetup{pdfinfo={Author={\theauthor},Title={\thetitle}}}\justify}
\else
	\AtBeginDocument{\hypersetup{pdfinfo={Author={\theauthor},Title={\thetitle}}}\justify\selectlanguage{ngerman}}
\fi

\AtEndDocument{\backmatter\printbibliography[heading=bibintoc]}


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
\RequirePackage{chngcntr}									%Fußnoten

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
\newtheorem{mydef}{Definition}[chapter]
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
\setuldepth{a}\setlength{\ULdepth}{0.25ex}				%Unterstrichbstand minimieren
\renewcommand{\uline}[1]{\ul{#1}}						%Backwardscompatibility
\counterwithout{footnote}{chapter}						%Fußnoten fortlaufend nummerierens

\newcommand{\numberthis}{\addtocounter{equation}{1}\tag %Nummerierung bei align*-Umgebung
	{\theequation}}
\newcommand*{\justify}{\fontdimen2\font=0.4em			%Automatische Zeilenumbrüche
	\fontdimen3\font=0.2em\fontdimen4\font=0.1em\fontdimen7\font=0.1em\hyphenchar\font=`\-}

%----------------------------------------------------------------------------------------------
%		Abkürzungen
%----------------------------------------------------------------------------------------------
\newcommand{\pfeil}{\rotatebox[origin=c]{180}{$\Lsh$}}	%Pfeil für Aufzählung
\newcommand{\nix}{$\phantom{a}$}						%Unsichtbares Zeichen

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
%		langer Titel
%----------------------------------------------------------------------------------------------
\gdef\thelongtitle{\Huge\thetitle}						%Titelseite auch bei fehlendem Argument
\newcommand{\longtitle}[3]{
	\gdef\thetitle{#1 #2 #3}\orig@title{#1 #2 #3}
	\gdef\thelongtitle{
		{\Huge #1}\\[0.5\baselineskip]
		{\Large #2}\\[0.5\baselineskip]
		{\Huge #3}
	}
}

%----------------------------------------------------------------------------------------------
%		Autor
%----------------------------------------------------------------------------------------------
\gdef\theauthor{<AUTHOR>}
\let\orig@author=\author
\renewcommand{\author}[1]{\gdef\theauthor{#1}\orig@author{#1}}

%----------------------------------------------------------------------------------------------
%		Dozent
%----------------------------------------------------------------------------------------------
\gdef\theprof{<PROF>}
\newcommand{\prof}[1]{\gdef\theprof{#1}}

%----------------------------------------------------------------------------------------------
%		Semester
%----------------------------------------------------------------------------------------------
\gdef\theterm{\@date}									%Standardwert eingegebenes/aktuelles Datum
\newcommand{\term}[1]{\gdef\theterm{#1}}

\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%										HEADER												%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\clearscrheadfoot										%Keine Seitenzahl im Footer
\automark{chapter}										%Lebende Kolumnentitel
\lohead{\headmark}										%Kapitelname in Header
\rohead{\pagemark}										%Seitenzahl in Header


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%									TITELSEITE												%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\tpKurz}{
\begin{titlepage}
%	\includegraphics[scale=0.09]{Uni_Logo} \hfill
	
	\rule{\textwidth}{0.1em}
	
	\vspace{-1.25\baselineskip}
	
	\rule{\textwidth}{0.05em} \\ \nix \vspace{-1em} \\
	\vspace{0.125\textheight}
	
	\centering
	
	\textcolor{black!60!blue!90}{\textsc{\Huge\thetitle}}
	
	\vspace{0.025\textheight}
	\rule{0.4\textwidth}{0.05em}
	
	\vspace{0.5\baselineskip}
	
	\large \theterm
	\vspace{0.1\textheight}
	
	\textcolor{black!90!blue!90}{\Large \textsc{\theprof}}
	\vfill
	\textcolor{black!90!blue!90}{\large\textsc{\theauthor}}
	
	\vspace{0.1\textheight}
	\rule{\textwidth}{0.05em}
	
	\vspace{-1.15\baselineskip}
	
	\rule{\textwidth}{0.1em}
\end{titlepage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\tpLang}{
\begin{titlepage}
%	\includegraphics[scale=0.09]{Uni_Logo} \hfill
	
	\rule{\textwidth}{0.1em}
	
	\vspace{-1.25\baselineskip}
	
	\rule{\textwidth}{0.05em} \\ \nix \vspace{-1em} \\
	\vspace{0.125\textheight}
	
	\centering
	
	\textcolor{black!60!blue!90}{\textsc{\thelongtitle}}
	
	\vspace{0.025\textheight}
	\rule{0.4\textwidth}{0.05em}
	
	\vspace{0.5\baselineskip}
	
	\large \theterm
	\vspace{0.1\textheight}
	
	\textcolor{black!90!blue!90}{\Large \textsc{\theprof}}
	\vfill
	\textcolor{black!90!blue!90}{\large\textsc{\theauthor}}
	
	\vspace{0.1\textheight}
	\rule{\textwidth}{0.05em}
	
	\vspace{-1.15\baselineskip}
	
	\rule{\textwidth}{0.1em}
\end{titlepage}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\endinput

