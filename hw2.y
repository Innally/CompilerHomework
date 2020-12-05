%{
/*****************************************************************************
hw3.y
YACC
Date:
file
2020/10/01
*****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include<ctype.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif

int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);
%}

%token ADD MINUS MUTI DIV NUMBER
%left ADD MINUS
%left MUTI DIV
%right UMINUS

%%

lines   :   lines expr ';'{printf("%f\n",$2);}
        |   lines '\n'
        |
        ;
expr    :   expr ADD expr   {$$=$1+$3;}
        |   expr MINUS expr   {$$=$1-$3;}
        |   expr MUTI expr   {$$=$1*$3;}
        |   expr DIV expr   {$$=$1/$3;}
        |   '(' expr ')'    {$$=$2;}
        |   MINUS expr %prec UMINUS {$$=-$2;}
        |   NUMBER  {$$=$1;}
        ;

%%

// programs section

int yylex()
{
    // place your token retrieving code here
    // place your token retrieving code here
    int t ;
    while (1) {
        t = getchar ();
        if (t == ' ' || t== '\t' || t == '\n'){
        //do nothinqg
        }
        else if (t=='+')
            return ADD;
        else if(t=='-')
            return MINUS;
        else if(t=='*')
            return MUTI;
        else if(t=='/')
            return DIV;
        else if ( isdigit (t)) {
            yylval = 0;
            while ( isdigit (t)) 
            {
                yylval = yylval * 10 + t - '0';
                t = getchar ();
            }
            ungetc(t , stdin );
            return NUMBER;
          }
        else {
            return t ;
            }
    }
}

int main(void)
{
    yyin = stdin ;
    do
    {
        yyparse();
    }while (! feof (yyin));
    return 0;
}
void yyerror(const char* s) {
    fprintf (stderr , "Parse error : %s\n", s );
    exit (1);
}
