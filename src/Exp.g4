grammar Exp;
program : block '.' ;


block :  variable* method+
;

variable : variableConst? TYPE IDENT (ASSIGN variableValue)? END_STATEMENT ;
variableConst: 'const';
variableValue: NUMBER|BOOLVALUE;

method: 'function' IDENT '(' (parameter (',' parameter)*)? ')' ':' returnParam  variable* 'begin' statement+ 'end';
parameter: TYPE IDENT;
returnParam: TYPE | 'void';

statement :  assignment
              | 'begin' statement+ 'end'
              | callStatement END_STATEMENT
              | ifCondition
              | whileStatement
			  | repeatStatement
			  | doWhileStatement
			  | forStatement
			  | switchStatement
			  | ternaryOperation
			  | paralelAssignment
			  | retrn
			  | unaryOperation END_STATEMENT
			;

forStatement: 'for' '('condition';' unaryOperation ')' statement; // predelal jsem for aby to bylo mene problematicke
whileStatement: 'while' '('condition')' 'do' statement;
doWhileStatement: 'do' statement 'while' '('condition')';
repeatStatement: 'repeat' statement 'until' '(' condition ')';
ifCondition: 'if' '('condition')' 'then' (statement)+ ('else' (statement)+)? ;
switchStatement: 'switch' '(' IDENT ')' '{' (cas)* defaultcas'}';
ternaryOperation: IDENT ':=' '(' condition ')' '?' expression ':' expression END_STATEMENT;
callStatement: 'call' IDENT;


assignment: IDENT ASSIGN expression multipleAssignment* END_STATEMENT;
multipleAssignment  : (',' IDENT ASSIGN expression);
paralelAssignment: '{' IDENT (',' IDENT)+ '}' ASSIGN '{' (expression) (',' (expression))+ '}' END_STATEMENT;


cas : 'case' NUMBER ':' (statement)* 'break'END_STATEMENT;
defaultcas: 'default' ':' (statement)* 'break'END_STATEMENT;

retrn : 'return' IDENT? END_STATEMENT; // return something; / return;
unaryOperation: IDENT unaryOperator;
unaryOperator: '++' | '--';

condition : expression COMPARATOR expression;

expression : PREOPERATION?term (PREOPERATION term)* //TODO pridelat unarni znamenko pred cislem ... potom
        | NEGATION?factor (BOOLOPERATION NEGATION?factor)*
        ; //TODO mozna jeste neco chybi.. zatim mi nic nenapada

term : factor (MULDIV factor)*; //pridano kvuli operaci nasobeni a deleni

factor : BOOLVALUE
        | NUMBER
        | callStatement //TODO check
        | '(' expression ')'
        | IDENT;

//lexer rules

BOOLVALUE : 'true' | 'false';
TYPE : 'bool' | 'int';
COMPARATOR: '='|'#'|'<'|'<='|'>'|'>=';
PREOPERATION: '+' | '-' ;
BOOLOPERATION: '|' | '&';
MULDIV : '*' | '/';
ASSIGN: ':=';
END_STATEMENT: ';';
NEGATION: '!';
// this lexer rules have to be in the last place
IDENT : ([a-zA-Z])([a-zA-Z0-9])*;
NUMBER : [0-9]+;

// skipped tokens
WS :   [ \t\r\n] -> skip ;



