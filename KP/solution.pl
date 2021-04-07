sex(oleg_pleshkov, m).
sex(alexey_pleshkov, m).
sex(gennadii_levakov, m).
sex(alexander_pleshkov, m).
sex(alexander_marakasov, m).
sex(nikolay_popov, m).
sex(balmyxammed_kikimov, m).
sex(sergei_pleshkov, m).
sex(andrey_nazarenko, m).
sex(alexander_nazarenko, m).
sex(pavel_skibinskii, m).
sex(evgenii_soloduhin, m).
sex(roman_soloduhin, m).
sex(mikhail_kikimov, m).
sex(alexander_kikimov, m).
sex(bosya, m).
sex(irina_levakova, f).
sex(natalya_kikimova, f).
sex(nina_popova, f).
sex(alexandra_pleshkova, f).
sex(tatyana_marakasova, f).
sex(anna, f).
sex(kapitalina, f).
sex(volya, f).
sex(elena_levakova, f).
sex(ekaterina_skibinskaya, f).
sex(nadejda, f).

parents(oleg_pleshkov, alexander_pleshkov, nina_popova).
parents(alexey_pleshkov, oleg_pleshkov, irina_levakova).
parents(gennadii_levakov, father_NAN, mother_NAN).
parents(alexander_pleshkov, sergei_pleshkov, volya).
parents(alexander_marakasov, father_NAN, mother_NAN).
parents(nikolay_popov, father_NAN, mother_NAN).
parents(balmyxammed_kikimov, father_NAN, mother_NAN).
parents(sergei_pleshkov, father_NAN, mother_NAN).
parents(andrey_nazarenko, father_NAN, mother_NAN).
parents(alexander_nazarenko, andrey_nazarenko, elena_levakova).
parents(pavel_skibinskii, father_NAN, mother_NAN).
parents(evgenii_soloduhin, father_NAN, mother_NAN).
parents(roman_soloduhin, evgenii_soloduhin, ekaterina_skibinskaya).
parents(mikhail_kikimov, balmyxammed_kikimov, kapitalina).
parents(alexander_kikimov, mikhail_kikimov, nadejda).
parents(bosya, balmyxammed_kikimov, kapitalina).
parents(irina_levakova, gennadii_levakov, natalya_kikimova).
parents(natalya_kikimova, balmyxammed_kikimov, kapitalina).
parents(nina_popova, nikolay_popov, anna).
parents(alexandra_pleshkova, oleg_pleshkov, irina_levakova).
parents(tatyana_marakasova, alexander_marakasov, irina_levakova).
parents(anna, father_NAN, mother_NAN).
parents(kapitalina, father_NAN, mother_NAN).
parents(volya, father_NAN, mother_NAN).
parents(elena_levakova, gennadii_levakov, natalya_kikimova).
parents(ekaterina_skibinskaya, pavel_skibinskii, elena_levakova).
parents(nadejda, father_NAN, mother_NAN).

brother(X,Y) :- parents(X,A,B), parents(Y,A,B), X\=Y, A\=father_NAN, B\=mother_NAN, sex(X,m).

married(Y) :- parents(_,_,Y).

shurin(X,Y) :- brother(X,Y), married(Y).

sister(X,Y) :- parents(X,A,B), parents(Y,A,B), X\=Y, A\=father_NAN, B\=mother_NAN, sex(X,f).

father(X,Y) :- parents(X,Y,_), Y\=father_NAN.

mother(X,Y) :- parents(X,_,Y), Y\=mother_NAN.

son(X,Y) :- 
    parents(X,Y,_), Y\=father_NAN, sex(X,m);
    parents(X,_,Y), Y\=mother_NAN, sex(X,m).

daughter(X,Y) :- 
    parents(X,Y,_), Y\=father_NAN, sex(X,f);
    parents(X,_,Y), Y\=mother_NAN, sex(X,f).

grandfather(X,Y):-
	father(X,Z),
	parents(Z,Y,_).

grandmother(X,Y):-
	father(X,Z),
	parents(Z,_,Y).

relative(X, First, Second) :- relative1(X, First, Second).
relative(X, First, Second) :- relative2(X, First, Second,[]).

relative1(son,Son,Parent) :- son(Son,Parent).
relative1(daughter,Daughter,Parent) :- daughter(Daughter,Parent).
relative1(sister,Sister,Brother) :- sister(Sister,Brother).
relative1(brother,Brother,Sister) :- brother(Brother,Sister).
relative1(father,Father,Child) :- father(Child,Father).
relative1(mother,Mother,Child) :- mother(Child,Mother).
relative1(grandfather,G,Child) :- grandfather(Child,G).
relative1(grandmother,G,Child) :- grandmother(Child,G).
relative1(husband,Husband,Wife) :- parents(_,Husband,Wife), Husband\=father_NAN, Wife\=mother_NAN, !.
relative1(wife,Wife,Husband) :- parents(_,Husband,Wife), Husband\=father_NAN, Wife\=mother_NAN, !.

relative2(X,_,_,_) :- X \= [].
relative2(X,First,Second,L) :- 
    relative1(_,Second,B),
    relative1(C,First,B), relative1(D,B,Second),
    not(my_member(B,L)), my_append(L,[D,B],L1), X=[C-D],
    relative2(X, First, Second,L1).

my_append([],X,X).
my_append([A|X],Y,[A|Z]) :- my_append(X,Y,Z).

my_member(X, [X|_]).
my_member(X,[_|Y]) :- my_member(X,Y).
