%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{cookbook}[Recipe]
\LoadClass[openany,10pt,letterpaper]{book}
\usepackage[letterpaper, portrait, margin=1in]{geometry} % for the margins
\usepackage[T1]{fontenc}
\usepackage{gensymb}
\usepackage{enumitem}
\usepackage{xparse}
\usepackage{fancyhdr}
\usepackage{xfrac}
\pagestyle{empty} % no page numbers
% Ingredients list
\fancyhf{}
% TODO: Improve parsing, maybe have it check to make sure that the optional argument reads `multi`

\NewDocumentEnvironment{recipe}{mo}{
% print recipe title
	\hfil{\MakeUppercase{\titlesize{\bf #1}}}
	\vspace{0.4em}
	\hrule
	\vspace{0.2em}
	\begin{list}{}{
	\setlength{\leftmargin}{1em}
	}
	%\vspace{1cm}
	\item[]
}{\end{list} \IfNoValueTF{#2}{\newpage}{\vspace{1.5em}}}

% The next 4 commands are optional add-ins
\newcommand{\blurb}[1]{\textit{#1} \bigbreak } % A text blurb about the recipe. Maybe a story? Maybe some options? 
\newcommand{\yield}[1]{\textsc{Yields:} #1 \hfill} % 
\newcommand{\acttime}[1]{\textit{\textsc{Active Time:}} #1 \hfill}
\newcommand{\inacttime}[1]{\textit{\textsc{Inactive Time:}} #1}
\newcommand{\ingredients}{
% Make a list of ingredients
        \par
        \textbf{\textsc{Ingredients: }}
	\begin{itemize}
	\@checkIngredients
}
\newcommand\@checkIngredients{
\@ifnextchar\stopIngredients{\@endIngredients}{\@addIngredient}
}
\newcommand\@addIngredient[1]{
    \item[-] {#1}
    \@checkIngredients
}
\newcommand\@endIngredients[1]{
    \end{itemize}
}
\newcommand{\preparation}{
%List the steps
	\vspace{0.5cm}
	\textbf{\textsc{Preparation: }}
	\begin{enumerate}[label=\textbf{\arabic*}. ]
	\@checkPrep
}
\newcommand\@checkPrep{
    \@ifnextchar\stopprep{\@endPrep}{\@addStep}
}
\newcommand\@addStep[1]{
	\item {#1}
	\@checkPrep
}
\newcommand\@endPrep[1]{
\vspace{-5mm}
\end{enumerate}
}
\newcommand\blankfootnote[1]{%
  \let\thefootnote\relax\footnotetext{#1}%
  \let\thefootnote\svthefootnote%
}
\let\svfootnote\footnote
\renewcommand\footnote[2][?]{%
  \if\relax#1\relax%
    \blankfootnote{#2}%
  \else%
    \if?#1\svfootnote{#2}\else\svfootnote[#1]{#2}\fi%
  \fi
}
\newcommand{\source}[1]{\footnote[]{#1}}
\def\titlesize{\large}
