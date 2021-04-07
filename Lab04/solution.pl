parent(alexey,tolia).
parent(alexey,volodia).
parent(tolia,tima).
parent(tolia,vova).
parent(tolia,kolya).
 
slovar_name([tolia,toli,tolin]).
slovar_name([alexey,alexeya,alexeya]).
slovar_name([tima,timi,timin]).
slovar_name([volodia,volodi,volodin]).
slovar_name([vova,vovi,vovin]).
slovar_name([kolya,koli,kolin]).
 
brother(X,Y):-parent(Z,X), parent(Z,Y), X\=Y.

answer([X,brat,Y,'?'],L) :- 
    brother(X,Y1),
    slovar_name([X,_,_]),
    slovar_name([Y1,Y,_]), L='yes',!; X\='chei', X\='kto', L='no'.
answer([kto,X,brat,'?'],L) :- 
    brother(X1,L),
    slovar_name([X1,_,X]).
answer([chei,brat,X,'?'],L) :- 
    brother(X,Y),
    slovar_name([Y,_,L]).

%?-answer([volodia,brat,toli,'?'],X).
%?-answer([kto,tolin,brat,'?'],X).
%?-answer([chei,brat,volodia,'?'],X).
%?-answer([vova,brat,timi,'?'],X).
%?-answer([kto,kolin,brat,'?'],X).
%?-answer([chei,brat,vova,'?'],X).
