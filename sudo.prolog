sudo(M) :- 	verif_ligne(M),
		transposee(M,MT),
		verif_ligne(MT),
		verif(1,M).

verif_ligne1([[A|LA],[B|LB],[C|LC]])	:-	verif(0,[A,B,C]),
					verif_ligne1([LA,LB,LC]).
verif_ligne1([[],[],[]]).


verif_ligne([A|L]) :- verif_ligne1(A),
				verif_ligne(L).
verif_ligne([]).

/* 
 chiffre :0
 case : 1
 ligne : 2
 cube : 3
 */
verif(N,[[A,B,C],L1,L2]) :- N \= 0,
			verif(N,[L1,L2,[]]),
			N1 is N - 1,
			verif(N1,A),verif(N1,B),verif(N1,C).
			
verif(_,[[],[],[]]).

/* element = chiffre */
verif(0,[[A,B,C],[D,E,F],[G,H,I]]) :- 	appartient([A,B,C,D,E,F,G,H,I],1),
					appartient([A,B,C,D,E,F,G,H,I],2),
					appartient([A,B,C,D,E,F,G,H,I],3),
					appartient([A,B,C,D,E,F,G,H,I],4),
					appartient([A,B,C,D,E,F,G,H,I],5),
					appartient([A,B,C,D,E,F,G,H,I],6),
					appartient([A,B,C,D,E,F,G,H,I],7),
					appartient([A,B,C,D,E,F,G,H,I],8),
					appartient([A,B,C,D,E,F,G,H,I],9).
/*verif(0,[[A,B,C],[D,E,F],[G,H,I]]) :-     tri([A,B,C,D,E,F,G,H,I],[A1,B1,C1,D1,E1,F1,G1,H1,I1]),	A1=1,B1=2,C1=3,D1=4,E1=5,F1=6,G1=7,H1=8,I1=9.*/


/* appartient */
appartient([_|L],Y) :- appartient(L,Y).
appartient([X|_],Y) :- X=Y.

/* transposée */
transposee([[A,B,C],[D,E,F],[G,H,I]],MT) :- tr(A,AT),tr(B,BT),tr(C,CT),tr(D,DT),tr(E,ET),tr(F,FT),tr(G,GT),tr(H,HT),tr(I,IT),tr([[AT,BT,CT],[DT,ET,FT],[GT,HT,IT]],MT).
tr([[]|_],[]).

tr(M,[X|Y]) :-	prem(M,X),     /* La première ligne du résultat est X */
		reste(M,Z),    /* Récupérer dans X la 1ere colonne de M */
		tr(Z,Y).       /* Z est la matrice M privée de sa 1ere colonne */

prem([],[]).

prem([[X|_]|M] , [X|L] ) :- prem(M,L).

reste([] , []).

reste([[_|L]|M] , [L|Z]) :-  reste(M,Z).


perm1(List,[H|Perm]):-supp(H,List,Rest),perm(Rest,Perm).
perm1([],[]).

/* sort */
supp(X,[X|T],T).
supp(X,[H|T],[H|NT]):-supp(X,T,NT).

tri(List,Sorted):-perm1(List,Sorted),is_sorted(Sorted).

is_sorted([]).
is_sorted([_]).
is_sorted([X,Y|T]):-X=<Y,is_sorted([Y|T]).


/*
verif(1,[[[[5,7,2],[3,4,8],[9,1,6]],[[3,9,8],[2,6,1],[5,7,4]],[[1,4,6],[9,5,7],[2,3,8]]],[[[1,9,4],[6,2,5],[8,3,7]],[[7,8,2],[9,4,3],[6,1,5]],[[3,6,5],[8,7,1],[4,2,9]]],[[[7,8,9],[4,5,1],[2,6,3]],[[4,3,6],[8,2,7],[1,5,9]],[[5,1,2],[6,9,3],[7,8,4]]]]).
*/