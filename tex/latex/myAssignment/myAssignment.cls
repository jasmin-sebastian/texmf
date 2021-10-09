%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%								KLASSE FÜR ÜBUNGSZETTEL										%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myAssignment}[2019/03/03 LaTeX Klasse für Übungszettel]


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
\ProcessKeyvalOptions{myAssignment}\relax

%----------------------------------------------------------------------------------------------
%		Optionen über Kondition
%----------------------------------------------------------------------------------------------
\newif\if@useEnglish\@useEnglishfalse
\DeclareOption{english}{\@useEnglishtrue}					%Option Englisch

\DeclareOption{twocolumn}{\OptionNotUsed}					%Option Zweispaltig nicht benutzen
\DeclareOption{twoside}{\OptionNotUsed}						%Option Zweiseitig nicht benutzen

%----------------------------------------------------------------------------------------------
%		Optionen übergeben
%----------------------------------------------------------------------------------------------
\PassOptionsToClass{\myAssignment@fntsize}{scrartcl}		%Standardschriftgröße übergeben
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
	\AtBeginDocument{\hypersetup{pdfinfo={Author={\theauthor},Title={\thetitle\, - Blatt \thenumber}}}\justify\HeaderFirstPageEnglish}
\else
	\AtBeginDocument{\hypersetup{pdfinfo={Author={\theauthor},Title={\thetitle\, - Blatt \thenumber}}}\justify\selectlanguage{ngerman}\HeaderFirstPage}
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
\RequirePackage{scrlayer-scrpage}							%Header
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
\setlist[enumerate,1]{label=\alph*)}
\setlist[enumerate,2]{label=\arabic*.}
\setlist[enumerate,3]{label=(\roman*)}
\if@useEnglish
	\renewcommand{\thesection}{Exercise \arabic{section}}
\else
	\renewcommand{\thesection}{Aufgabe \arabic{section}}
\fi

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
\RequirePackage{ifthen}
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
%		Tutor
%----------------------------------------------------------------------------------------------
\gdef\thetutor{<TUTOR>}
\newcommand{\tutor}[1]{\gdef\thetutor{#1}}

%----------------------------------------------------------------------------------------------
%		Zettelnummer
%----------------------------------------------------------------------------------------------
\gdef\thenumber{<ZETTELNUMMER>}
\newcommand{\nr}[1]{\gdef\thenumber{#1}}

%----------------------------------------------------------------------------------------------
%		Semester
%----------------------------------------------------------------------------------------------
\gdef\theterm{\@date}									%Standardwert eingegebenes/aktuelles Datum
\newcommand{\term}[1]{\gdef\theterm{#1}}

%----------------------------------------------------------------------------------------------
%		Punktetabelle
%----------------------------------------------------------------------------------------------
\gdef\thepunktetabelle{\punktetabelleiv}
\newcommand{\tasks}[1]{\gdef\thepunktetabelle{
	\ifthenelse{\equal{#1}{1}}{\punktetabellei}{
		\ifthenelse{\equal{#1}{2}}{\punktetabelleii}{
			\ifthenelse{\equal{#1}{3}}{\punktetabelleiii}{
				\ifthenelse{\equal{#1}{4}}{\punktetabelleiv}{
					\ifthenelse{\equal{#1}{5}}{\punktetabellev}{
						\ifthenelse{\equal{#1}{6}}{\punktetabellevi}{
							\ifthenelse{\equal{#1}{7}}{\punktetabellevii}{
								\ifthenelse{\equal{#1}{8}}{\punktetabelleviii}{
									\ifthenelse{\equal{#1}{9}}{\punktetabelleix}{
										\ifthenelse{\equal{#1}{10}}{\punktetabellex}{
											\ifthenelse{\equal{#1}{none}}{
												\large Punkte: \normalsize}
												{\vspace{-3\baselineskip}}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}}

\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%										HEADER												%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\HeaderFirstPage}{
	\thispagestyle{plain}
	\nix \vspace{-3.5\headheight} \\
	\rule{\textwidth}{0.01em} \vspace{-1.75\baselineskip}
	\textsl{
	\begin{center}
		\thetitle\, - Übungszettel \thenumber \\
		\theterm
	\end{center} \vspace{-\baselineskip}
	\textup{Tutor:} \thetutor \\
	\textup{Name:} \theauthor \vspace{-0.5\baselineskip} \\}
	\rule{\textwidth}{0.01em} \vspace{\baselineskip} \\
	\thepunktetabelle
}

\newcommand{\HeaderFirstPageEnglish}{
	\thispagestyle{plain}
	\nix \vspace{-3.5\headheight} \\
	\rule{\textwidth}{0.01em} \vspace{-1.75\baselineskip}
	\textsl{
		\begin{center}
			\thetitle\, - Assignment \thenumber \\
			\theterm
		\end{center} \vspace{-\baselineskip}
		\textup{Tutor:} \thetutor \\
		\textup{Name:} \theauthor \vspace{-0.5\baselineskip} \\}
	\rule{\textwidth}{0.01em} \vspace{\baselineskip} \\
	\thepunktetabelle
}

\clearscrheadfoot
\lohead{\theauthor}
\rohead{\pagemark}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																							%%%
%%%									PUNKTETABELLE											%%%
%%%																							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------------------------------------------------------------------------
%		Punktetabelle mit einer Aufgabe
%----------------------------------------------------------------------------------------------
\newcommand{\punktetabellei}{
	\begin{tabular}{C{1cm}|C{1cm}}
		1 & $\sum$ \\
		\hline	&\\&\\
	\end{tabular} \vspace{8pt} \\
}

%----------------------------------------------------------------------------------------------
%		Punktetabelle mit zwei Aufgaben
%----------------------------------------------------------------------------------------------
\newcommand{\punktetabelleii}{
	\begin{tabular}{C{1cm}|C{1cm}|C{1cm}}
		1 & 2 & $\sum$ \\
		\hline	&&\\&&\\
	\end{tabular} \vspace{8pt} \\
}

%----------------------------------------------------------------------------------------------
%		Punktetabelle mit drei Aufgaben
%----------------------------------------------------------------------------------------------
\newcommand{\punktetabelleiii}{
	\begin{tabular}{C{1cm}|C{1cm}|C{1cm}|C{1cm}}
		1 & 2 & 3 & $\sum$ \\
		\hline	&&&\\&&&\\
	\end{tabular} \vspace{8pt} \\
}

%----------------------------------------------------------------------------------------------
%		Punktetabelle mit vier Aufgaben
%----------------------------------------------------------------------------------------------
\newcommand{\punktetabelleiv}{
	\begin{tabular}{C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}}
		1 & 2 & 3 & 4 & $\sum$ \\
		\hline	&&&&\\&&&&\\
	\end{tabular} \vspace{8pt} \\
}

%----------------------------------------------------------------------------------------------
%		Punktetabelle mit fünf Aufgaben
%----------------------------------------------------------------------------------------------
\newcommand{\punktetabellev}{
	\begin{tabular}{C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}}
		1 & 2 & 3 & 4 & 5 & $\sum$ \\
		\hline	&&&&&\\
		&&&&&\\
	\end{tabular} \vspace{8pt} \\
}

%----------------------------------------------------------------------------------------------
%		Punktetabelle mit sechs Aufgaben
%----------------------------------------------------------------------------------------------
\newcommand{\punktetabellevi}{
	\begin{tabular}{C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}}
		1 & 2 & 3 & 4 & 5 & 6 & $\sum$ \\
		\hline	&&&&&&\\&&&&&&\\
	\end{tabular} \vspace{8pt} \\
}

%----------------------------------------------------------------------------------------------
%		Punktetabelle mit sieben Aufgaben
%----------------------------------------------------------------------------------------------
\newcommand{\punktetabellevii}{
	\begin{tabular}{C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}}
		1 & 2 & 3 & 4 & 5 & 6 & 7 & $\sum$ \\
		\hline	&&&&&&&\\&&&&&&&\\
	\end{tabular} \vspace{8pt} \\
}

%----------------------------------------------------------------------------------------------
%		Punktetabelle mit acht Aufgaben
%----------------------------------------------------------------------------------------------
\newcommand{\punktetabelleviii}{
	\begin{tabular}{C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}}
		1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & $\sum$ \\
		\hline	&&&&&&&&\\&&&&&&&&\\
	\end{tabular} \vspace{8pt} \\
}

%----------------------------------------------------------------------------------------------
%		Punktetabelle mit neun Aufgaben
%----------------------------------------------------------------------------------------------
\newcommand{\punktetabelleix}{
	\begin{tabular}{C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}}
		1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & $\sum$ \\
		\hline	&&&&&&&&\\&&&&&&&&\\
	\end{tabular} \vspace{8pt} \\
}

%----------------------------------------------------------------------------------------------
%		Punktetabelle mit zehn Aufgaben
%----------------------------------------------------------------------------------------------
\newcommand{\punktetabellex}{
	\begin{tabular}{C{0.9cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{1cm}|C{0.9cm}}
		1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & $\sum$ \\
		\hline	&&&&&&&&&\\&&&&&&&&&\\
	\end{tabular} \vspace{8pt} \\
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\endinput

