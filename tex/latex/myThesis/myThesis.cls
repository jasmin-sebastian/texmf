%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																			  %%%
%%%					 KLASSE FÜR ARBEITEN									  %%%
%%%																			  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myThesis}[2020/11/26 LaTeX Klasse für Arbeiten]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																			  %%%
%%%					 OPTIONEN DEKLARIEREN									  %%%
%%%																			  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------------
%		Optionen über String
%--------------------------------------------------------------------------------
\RequirePackage{kvoptions}								%Stringoption
\DeclareStringOption[12pt]{fntsize}						%Standardschriftgröße
\ProcessKeyvalOptions{myThesis}\relax

%--------------------------------------------------------------------------------
%		Optionen über Kondition
%--------------------------------------------------------------------------------
\newif\if@useLongtitle\@useLongtitlefalse
\DeclareOption{longtitle}{\@useLongtitletrue}			%Option langer Titel

\newif\if@uselof\@useloftrue
\DeclareOption{nolof}{\@useloffalse}					%Option keine LOF

\newif\if@uselot\@uselottrue
\DeclareOption{nolot}{\@uselotfalse}					%Option keine LOT

\newif\if@useEnglish\@useEnglishfalse
\DeclareOption{english}{\@useEnglishtrue}				%Option Englisch

\DeclareOption{twocolumn}{\OptionNotUsed}				%Option Zweispaltig

\newif\if@useTimes\@useTimesfalse
\DeclareOption{times}{\@useTimestrue}				%Option Times New Roman Font

\newif\if@useArial\@useArialfalse
\DeclareOption{arial}{\@useArialtrue}					%Option Arial Font

\newif\if@useAPA\@useAPAfalse
\DeclareOption{apa}{\@useAPAtrue}						%Option authoryear style

\newif\if@useNum\@useNumfalse
\DeclareOption{num}{\@useNumtrue}						%Option numeric style

\gdef\thecolor{black}
\newif\if@useColor\@useColorfalse
\DeclareOption{green}{\@useColortrue\gdef\thecolor{green!50!black}}%Option green color scheme
\DeclareOption{blue}{\@useColortrue\gdef\thecolor{blue!70!black}}%Option blue color scheme

%--------------------------------------------------------------------------------
%		Optionen übergeben
%--------------------------------------------------------------------------------
\PassOptionsToClass{\myThesis@fntsize}{scrbook}	%Standardschriftgröße übergeben
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}%alle Optionen könnnen übergeben werden
\ExecuteOptions{times}									%Default Optionen
\ProcessOptions\relax

%--------------------------------------------------------------------------------
%		Klasse mit Optionen laden
%--------------------------------------------------------------------------------
\LoadClass[a4paper,parskip=half]{scrbook}

\KOMAoptions{headinclude,chapterprefix,listof=toc}		%Komaoptionen hier
\recalctypearea									%Typearea von Headerpaket benutzt

%--------------------------------------------------------------------------------
%		Titelseite über Kondition
%--------------------------------------------------------------------------------
\RequirePackage{etoolbox}							%AfterEndPreamble, patchcmd
\RequirePackage[ngerman,main=english]{babel}			%Standardsprache English

\if@useEnglish
\if@useLongtitle
\AfterEndPreamble{\tpLangEnglisch\frontmatter\decEng\tableofcontents\mainmatter}
\else
\AfterEndPreamble{\tpKurzEnglisch\frontmatter\decEng\tableofcontents\mainmatter}
\fi
\else
\if@useLongtitle
\AfterEndPreamble{\tpLang\frontmatter\dec\tableofcontents\mainmatter}
\else
\AfterEndPreamble{\tpKurz\frontmatter\dec\tableofcontents\mainmatter}
\fi
\fi

%--------------------------------------------------------------------------------
%		Packages für Literatur
%--------------------------------------------------------------------------------
\RequirePackage[utf8]{inputenc}								%Kodierung (Umlaute)
\RequirePackage[T1]{fontenc}								%Kodierung (z.B. >/<)
\RequirePackage[nogroupskip,toc]{glossaries}				%Glossar
\RequirePackage[autostyle=true]{csquotes}
\if@useAPA
\RequirePackage[backend=biber,style=authoryear]{biblatex}
\else
\if@useNum
\RequirePackage[backend=biber,style=numeric]{biblatex}
\else
\RequirePackage[backend=biber,style=alphabetic]{biblatex}
\fi
\fi

%--------------------------------------------------------------------------------
%		Sprache über Kondition
%--------------------------------------------------------------------------------
\if@useEnglish
\AtBeginDocument{\hypersetup{pdfinfo={Author={\theauthor},Title={\thetitle}}}\justify}
\ExecuteBibliographyOptions{sortlocale=en_US,maxbibnames=99}
\else
\AtBeginDocument{\hypersetup{pdfinfo={Author={\theauthor},Title={\thetitle}}}\justify\selectlanguage{ngerman}}
\ExecuteBibliographyOptions{sortlocale=de_DE,maxbibnames=99}
\fi


%--------------------------------------------------------------------------------
%		List of Figures/Tables über Kondition
%--------------------------------------------------------------------------------
\if@uselof
\if@uselot
\AtEndDocument{\backmatter\printnoidxglossary\listoffigures\listoftables\printbibliography[heading=bibintoc]}
\else
\AtEndDocument{\backmatter\printnoidxglossary\listoffigures\printbibliography[heading=bibintoc]}
\fi
\else
\if@uselot
\AtEndDocument{\backmatter\printnoidxglossary\listoftables\printbibliography[heading=bibintoc]}
\else
\AtEndDocument{\backmatter\printnoidxglossary\printbibliography[heading=bibintoc]}
\fi
\fi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																			  %%%
%%%					 PAKETE LADEN											  %%%
%%%																			  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------------
%		Pakete für Standarteingabe
%--------------------------------------------------------------------------------
\RequirePackage{microtype}							%Mikrotypografiekorrekturen
\RequirePackage{setspace}									%Zeilenabstand
\if@useTimes
\RequirePackage{mathptmx}									%Times New Roman
\fi
\if@useArial
\RequirePackage{helvet}										%Arial
\renewcommand{\familydefault}{\sfdefault}
\fi

%--------------------------------------------------------------------------------
%		Allgemeine Pakete
%--------------------------------------------------------------------------------
\RequirePackage{amsthm,amsmath,amssymb,amsopn,mathtools,bbm}%Mathepakete
\RequirePackage{multirow,array,longtable,booktabs}			%Tabellenpakete (z.B. neue Typen)
\RequirePackage[bible]{blindtext}							%Testen

%--------------------------------------------------------------------------------
%		Pakete für Layoutveränderungen
%--------------------------------------------------------------------------------
\RequirePackage[headsepline]{scrlayer-scrpage}				%Header
\RequirePackage{enumitem}									%Itemizelayout
\RequirePackage{multicol}									%Mehrere Spalten
\RequirePackage{hyperref}									%Linkhervorhebung
\RequirePackage[normalem]{ulem}			%Unterstreichung gestrichelt, emph normal
\RequirePackage{soulutf8}				%Unterstreichung Abstand, Zeilenumbruch

%--------------------------------------------------------------------------------
%		Pakete für Design, Zeichnungen
%--------------------------------------------------------------------------------
\RequirePackage{graphicx}									%Bilder einfügen
\RequirePackage{float}								%Bilder an bestimmter Stelle
\RequirePackage{xcolor}										%Farbe
\RequirePackage{tikz,tikz-qtree,tikz-cd,pgfplots}			%Bäume, kommutative Diagramme, ER-Diagramme, etc.
\RequirePackage{listings}									%Source Code


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																			  %%%
%%%					 EINSTELLUNGEN											  %%%
%%%																			  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------------
%		Allgemeines Layout
%--------------------------------------------------------------------------------
\setcounter{tocdepth}{2}							%Tiefe Inhaltsverzeichnis

\if@useColor												%Links
\hypersetup{colorlinks=true,linkcolor=black,urlcolor=\thecolor,citecolor=\thecolor}
\else
\hypersetup{colorlinks=true,linkcolor=black,urlcolor=blue,citecolor=blue}
\fi

\setlist[itemize,2]{label=\pfeil}							%Listenlayout
\setlist[itemize,3]{label=$\rightarrow$}
\setlist[enumerate,3]{label=(\roman*)}

\makeatletter										%Alle Abbildungen zentrieren
\g@addto@macro\@floatboxreset\centering
\makeatother

%--------------------------------------------------------------------------------
%		Überschriften Layout
%--------------------------------------------------------------------------------
\renewcommand*{\chapterformat}{
	\fontsize{110pt}{0pt}\selectfont
	\raggedleft\itshape
	\textcolor{\thecolor}{$\mathfrak{\thechapter}$}
	\vspace{0.5em}\hrule\vspace{0.5em}
}

%--------------------------------------------------------------------------------
%		Matheeinstellungen
%--------------------------------------------------------------------------------
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

%--------------------------------------------------------------------------------
%		Layout Source Code/Tikz
%--------------------------------------------------------------------------------
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

\pgfplotsset{compat=1.17}								%Backwards compatibility
\usetikzlibrary{shapes,						%Weitere Knotenformen (z.B. Ellipse)
	shadows,											%Schattierung
	positioning,										%Position (z.B. right of)
	intersections,										%z.B. path
	arrows,												%Pfeile
	automata}									%Automaten (Start-/Endzustände)

%--------------------------------------------------------------------------------
%		Neue Spaltentypen
%--------------------------------------------------------------------------------
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}%Linksbündige Spalte mit fester Breite
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}%Rechtsbündige Spalte mit fester Breite
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}	%Zentrierte Spalte mit fester Breite
\newcolumntype{M}{>{$}l<{$}}							%Spalte im Mathemodus


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																			  %%%
%%%					 NEUE BEFEHLE											  %%%
%%%																			  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------------
%		Einstellungen
%--------------------------------------------------------------------------------
\newcommand{\pfeil}{\rotatebox[origin=c]{180}{$\Lsh$}}	%Pfeil für Aufzählung
\newcommand{\nix}{$\phantom{a}$}						%Unsichtbares Zeichen

\setuldepth{a}\setlength{\ULdepth}{0.25ex}			%Unterstrichbstand minimieren
\renewcommand{\uline}[1]{\ul{#1}}						%Backwardscompatibility

\newcommand{\numberthis}{\addtocounter{equation}{1}\tag %Nummerierung bei align*-Umgebung
	{\theequation}}
\newcommand*{\justify}{\fontdimen2\font=0.4em		%Automatische Zeilenumbrüche
	\fontdimen3\font=0.2em\fontdimen4\font=0.1em\fontdimen7\font=0.1em\hyphenchar\font=`\-}

%--------------------------------------------------------------------------------
%		Abkürzungen
%--------------------------------------------------------------------------------
\newcommand{\ra}{$\rightarrow$\,}						%Abkürzung Pfeil einfach
\newcommand{\Ra}{$\Rightarrow$\,}						%Abkürzung Pfeil doppelt


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																			  %%%
%%%					 VARIABELN												  %%%
%%%																			  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
%--------------------------------------------------------------------------------
%		Titel
%--------------------------------------------------------------------------------
\gdef\thetitle{<TITLE>}
\let\orig@title=\title
\renewcommand{\title}[1]{\gdef\thetitle{#1}\orig@title{#1}}

%--------------------------------------------------------------------------------
%		Untertitel
%--------------------------------------------------------------------------------
\gdef\thesubtitle{}
\let\orig@subtitle=\subtitle
\renewcommand{\subtitle}[1]{\gdef\thesubtitle{#1}\orig@subtitle{#1}}

%--------------------------------------------------------------------------------
%		langer Titel
%--------------------------------------------------------------------------------
\gdef\thelongtitle{\thetitle}			%Titelseite auch bei fehlendem Argument
\newcommand{\longtitle}[2]{
	\gdef\thetitle{#1 #2}\orig@title{#1 #2}
	\gdef\thelongtitle{#1 \\[0.5\baselineskip] #2}
}

%--------------------------------------------------------------------------------
%		Autor
%--------------------------------------------------------------------------------
\gdef\theauthor{<AUTHOR>}
\let\orig@author=\author
\renewcommand{\author}[1]{\gdef\theauthor{#1}\orig@author{#1}}

%--------------------------------------------------------------------------------
%		Dozent
%--------------------------------------------------------------------------------
\gdef\theprof{<PROF>}
\gdef\theprofname{DozentIn}
\gdef\theprofnameeng{Lecturer}
\newcommand{\prof}[2][d]{\gdef\theprof{#2}
	\ifthenelse{\equal{#1}{d}}{\gdef\theprofname{DozentIn}}{
		\ifthenelse{\equal{#1}{b}}{\gdef\theprofname{BetreuerIn}\gdef\theprofnameeng{Supervisor}}{
			\ifthenelse{\equal{#1}{df}}{\gdef\theprofname{Dozentin}}{
				\ifthenelse{\equal{#1}{dm}}{\gdef\theprofname{Dozent}}{
					\ifthenelse{\equal{#1}{bf}}{\gdef\theprofname{Betreuerin}\gdef\theprofnameeng{Supervisor}}{
						\ifthenelse{\equal{#1}{bm}}{\gdef\theprofname{Betreuer}\gdef\theprofnameeng{Supervisor}}{}
					}
				}
			}
		}
	}
}

%--------------------------------------------------------------------------------
%		Semester
%--------------------------------------------------------------------------------
\gdef\theterm{<TERM>}
\newcommand{\term}[1]{\gdef\theterm{#1}}

%--------------------------------------------------------------------------------
%		Matrikelnummer
%--------------------------------------------------------------------------------
\gdef\thematrikel{<MATRIKEL>}
\newcommand{\matrikel}[1]{\gdef\thematrikel{#1}}

%--------------------------------------------------------------------------------
%		Mail
%--------------------------------------------------------------------------------
\gdef\themail{<MAIL>}
\newcommand{\mail}[1]{\gdef\themail{#1}}

%--------------------------------------------------------------------------------
%		Studiengang
%--------------------------------------------------------------------------------
\gdef\thesubject{<SUBJECT>}
\let\orig@subject=\subject 
\renewcommand{\subject}[2]{\gdef\thesubject{#1, #2. Fachsemester}\orig@subject{#1}}

%--------------------------------------------------------------------------------
%		Datum
%--------------------------------------------------------------------------------
\gdef\thedate{\today}
\let\orig@date=\date
\renewcommand{\date}[1]{\gdef\thedate{#1}\orig@date{#1}}

%--------------------------------------------------------------------------------
%		Lehrstuhl
%--------------------------------------------------------------------------------
\gdef\thechair{}
\newcommand{\chair}[1]{\gdef\thechair{#1\\}}

%--------------------------------------------------------------------------------
%		Fakultät
%--------------------------------------------------------------------------------
\gdef\thefaculty{Fakultät für Mathematik und Informatik\\}
\newcommand{\faculty}[1]{
	\ifthenelse{\equal{#1}{}}{\gdef\thefaculty{}}{\gdef\thefaculty{#1\\}}
}

%--------------------------------------------------------------------------------
%		Linker Header
%--------------------------------------------------------------------------------
\gdef\thelhead{}									%Header für plain.scrheadings
\newcommand{\lhead}[1]{\gdef\thelhead{#1}}

%--------------------------------------------------------------------------------
%		Rechter Header
%--------------------------------------------------------------------------------
\gdef\therhead{}									%Header für plain.scrheadings
\newcommand{\rhead}[1]{\gdef\therhead{#1}}

%--------------------------------------------------------------------------------
%		Zusatzattribute
%--------------------------------------------------------------------------------
\gdef\thezusatzi{}
\newcommand{\zusatzi}[2]{\gdef\thezusatzi{#1: & #2 \\}}
\gdef\thezusatzii{}
\newcommand{\zusatzii}[2]{\gdef\thezusatzii{#1: & #2 \\}}
\gdef\thezusatziii{}
\newcommand{\zusatziii}[2]{\gdef\thezusatziii{#1: & #2 \\}}

%--------------------------------------------------------------------------------
%		Abstract
%--------------------------------------------------------------------------------
\gdef\theshortger{\blindtext}
\newcommand{\shortger}[1]{\gdef\theshortger{#1}}
\gdef\theshorteng{\blindtext}
\newcommand{\shorteng}[1]{\gdef\theshorteng{#1}}

\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																			  %%%
%%%					 HEADER													  %%%
%%%																			  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter

\newcounter{savepagenumber}
\automark[chapter]{chapter}

\renewcommand\frontmatter{
	\@mainmatterfalse
	\onehalfspacing
	\cleardoublepage
	\pagenumbering{roman}
}

\renewcommand\mainmatter{
	\@mainmattertrue
	\singlespacing
	\cleardoubleevenpage
	\cleardoublepage
	\setcounter{savepagenumber}{\value{page}}
	\pagenumbering{arabic}
}

\renewcommand\backmatter{
	\@mainmatterfalse
	\onehalfspacing
	\cleardoubleevenpage
	\Ifthispageodd{}{\cleardoublepage}
	\pagenumbering{roman}
	\setcounter{page}{\value{savepagenumber}}
}

\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																			  %%%
%%%					 TITELSEITE												  %%%
%%%																			  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\tpKurz}{\onehalfspacing
	\begin{titlepage}
		\raggedleft
		
		\textcolor{\thecolor}{\rule{1pt}{\textheight}}
		\hspace{0.05\textwidth}
		\parbox[b]{0.75\textwidth}{
			{\Huge\bfseries \thetitle}\\[2\baselineskip]
			{\large\textit{\thesubtitle}}\\[4\baselineskip]
			{\Large\textsc{\theauthor}}\\[0.5\baselineskip]$\phantom{a}$
			\begin{tabular}{ll}
				Matrikelnummer: & \thematrikel \\
				E-Mail: & \href{mailto:\themail}{\themail} \\
				Studiengang: & \thesubject \\
				\theprofname: & \theprof \\
				\thezusatzi
				\thezusatzii
				\thezusatziii
				Datum der Abgabe: & \thedate \\
			\end{tabular}
			
			\vspace{0.325\textheight}
			
			{\theterm}\\
			{\thechair}{\thefaculty}
			{Universität Heidelberg}\\[\baselineskip]
		}
	\end{titlepage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\tpKurzEnglisch}{\onehalfspacing
	\begin{titlepage}
		\raggedleft
		
		\textcolor{\thecolor}{\rule{1pt}{\textheight}}
		\hspace{0.05\textwidth}
		\parbox[b]{0.75\textwidth}{
			{\Huge\bfseries \thetitle}\\[2\baselineskip]
			{\large\textit{\thesubtitle}}\\[4\baselineskip]
			{\Large\textsc{\theauthor}}\\[0.5\baselineskip]$\phantom{a}$
			\begin{tabular}{ll}
				Matriculation number: & \thematrikel \\
				E-Mail: & \href{mailto:\themail}{\themail} \\
				Course of study: & \thesubject \\
				\theprofnameeng: & \theprof \\
				\thezusatzi
				\thezusatzii
				\thezusatziii
				Date of submission: & \thedate \\
			\end{tabular}
			
			\vspace{0.325\textheight}
			
			{\theterm}\\
			{\thechair}{\thefaculty}
			{Universität Heidelberg}\\[\baselineskip]
		}
	\end{titlepage}
	\cleardoublepage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\tpLang}{
	\begin{titlepage}
		\onehalfspacing
		\raggedleft
		
		\textcolor{\thecolor}{\rule{1pt}{\textheight}}
		\hspace{0.05\textwidth}
		\parbox[b]{0.75\textwidth}{
			{\Huge\bfseries \thelongtitle}\\[2\baselineskip]
			{\large\textit{\thesubtitle}}\\[4\baselineskip]
			{\Large\textsc{\theauthor}}\\[0.5\baselineskip]$\phantom{a}$
			\begin{tabular}{ll}
				Matrikelnummer: & \thematrikel \\
				E-Mail: & \href{mailto:\themail}{\themail} \\
				Studiengang: & \thesubject \\
				\theprofname: & \theprof \\
				\thezusatzi
				\thezusatzii
				\thezusatziii
				Datum der Abgabe: & \thedate \\
			\end{tabular}
			
			\vspace{0.275\textheight}
			
			{\theterm}\\
			{\thechair}{\thefaculty}
			{Universität Heidelberg}\\[\baselineskip]
		}
	\end{titlepage}
	\cleardoublepage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\tpLangEnglisch}{\onehalfspacing
	\begin{titlepage}
		\raggedleft
		
		\textcolor{\thecolor}{\rule{1pt}{\textheight}}
		\hspace{0.05\textwidth}
		\parbox[b]{0.75\textwidth}{
			{\Huge\bfseries \thelongtitle}\\[2\baselineskip]
			{\large\textit{\thesubtitle}}\\[4\baselineskip]
			{\Large\textsc{\theauthor}}\\[0.5\baselineskip]$\phantom{a}$
			\begin{tabular}{ll}
				Matriculation number: & \thematrikel \\
				E-Mail: & \href{mailto:\themail}{\themail} \\
				Course of study: & \thesubject \\
				\theprofnameeng: & \theprof \\
				\thezusatzi
				\thezusatzii
				\thezusatziii
				Date of submission: & \thedate \\
			\end{tabular}
			
			\vspace{0.275\textheight}
			
			{\theterm}\\
			{\thechair}{\thefaculty}
			{Universität Heidelberg}\\[\baselineskip]
		}
	\end{titlepage}
	\cleardoublepage
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																			  %%%
%%%				EIGENSTÄNDIGKEITSERKLÄRUNG									  %%%
%%%																			  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\dec}{
	\chapter*{Eigenständigkeitserklärung}
	\thispagestyle{empty}
	
	Ich versichere hiermit, dass ich die vorliegende Arbeit selbständig verfasst und keine anderen als die angegebenen Hilfsmittel benutzt habe. Sowohl inhaltlich als auch wörtlich entnommene Inhalte wurden als solche kenntlich gemacht.
	
	Die Arbeit ist in gleicher oder vergleichbarer Form noch bei keiner anderen Prüfungsbehörde eingereicht worden. \vspace{0.2\textheight}
	
	\begin{tabular}{lp{0.175\textwidth}l}
		Heidelberg, \thedate &&\\
		\rule{15em}{0.5pt} && \rule{12em}{0.5pt} \\
		{\scriptsize Ort, Datum} && {\scriptsize \theauthor} \\
	\end{tabular}
	
	\chapter*{Zusammenfassung}
	\thispagestyle{empty}
	\theshortger
	
	\chapter*{Abstract}
	\thispagestyle{empty}
	\theshorteng
}

\newcommand{\decEng}{
	\chapter*{Declaration of Authorship}
	\thispagestyle{empty}
	
	I hereby certify that I have written this work independently and no other resources as the specified were used. Both content and verbatim content have been identified as such.
	
	The thesis has not yet been submitted to any other examination authority in the same or comparable form. \vspace{0.2\textheight}
	
	\begin{tabular}{lp{0.175\textwidth}l}
		Heidelberg, \thedate &&\\
		\rule{15em}{0.5pt} && \rule{12em}{0.5pt} \\
		{\scriptsize Place, Date} && {\scriptsize \theauthor} \\
	\end{tabular}
	
	\chapter*{Abstract}
	\thispagestyle{empty}
	\theshorteng
	
	\chapter*{Zusammenfassung}
	\thispagestyle{empty}
	\theshortger
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\endinput

