%----------------------------------BASE_DE_DADOS----------------------------------

acesso(a, b, x1, 100, (1:10)).
acesso(a, b, x2, 110, (1:00)).
acesso(b, c, x3, 100, (2:10)).
acesso(c, d, x4, 100, (0:30)).
acesso(a, d, x5, 300, (3:30)).
acesso(a, e, x6, 100, (1:10)).
acesso(e, c, x7, 250, (2:40)).

%----------------------------------Exercicio_1------------------------------------

rotaDireta(CidadeA,CidadeB,Rodovia):-
acesso(CidadeA,CidadeB,Rodovia,_,_).

%----------------------------------Exercicio_2------------------------------------

caminho(CidadeA,CidadeB,[Rodovia]):-
acesso(CidadeA,CidadeB,Rodovia,_,_).
caminho(CidadeA,CidadeB,[Head|Tail]):-
acesso(CidadeA,CidadeC,Head,_,_),
caminho(CidadeC,CidadeB,Tail).

%----------------------------------Exercicio_3------------------------------------

menorCaminho(CidadeA,CidadeB,Distancia) :-
findall(Distancia, menorCaminhoAux(CidadeA,CidadeB,Distancia),Lista),
valorMinimo(Lista, Distancia).

menorCaminhoAux(CidadeA, CidadeB, Distancia) :-
acesso(CidadeA,CidadeB,_,Distancia,_).

menorCaminhoAux(CidadeA,CidadeB, Distancia):-
acesso(CidadeA,CidadeC,_,Head,_),
menorCaminhoAux(CidadeC,CidadeB,Tail),
Distancia is Head + Tail.

valorMinimo([Head|Tail], Distancia) :-
valorMinimoAux(Tail, Head, Distancia).

valorMinimoAux([], Distancia, Distancia).
valorMinimoAux([Head|Tail], Distancia1, Distancia) :-
min(Head, Distancia1, Distancia2),
valorMinimoAux(Tail, Distancia2, Distancia).

min(X,Y,X) :-
X = Y, !.
min(X,Y,X) :-
X < Y, !.
min(X,Y,Y) :-
X > Y.

%----------------------------------Exercicio_4------------------------------------

tempoMenorCaminho(CidadeA,CidadeB,Tempo) :-
findall(Distancia, tempoMenorCaminhoAux(CidadeA,CidadeB,Distancia,_), Lista),
findall(Tempo, tempoMenorCaminhoAux(CidadeA,CidadeB,_,Tempo),Lista1),
menorCaminhoTempo(Lista,_, Lista1, Tempo).

tempoMenorCaminhoAux(CidadeA, CidadeB, Distancia, Tempo) :-
acesso(CidadeA,CidadeB,_,Distancia, Tempo).
tempoMenorCaminhoAux(CidadeA,CidadeB, Distancia, Tempo):-
acesso(CidadeA,CidadeC,_,Distancia1,Tempo1),
tempoMenorCaminhoAux(CidadeC,CidadeB,Distancia2, Tempo2),
Distancia is Distancia1 + Distancia2,
somandoOTempoDoMenorCaminho(Tempo1,Tempo2,Tempo).

somandoOTempoDoMenorCaminho((H1:M1),(H2:M2),(HT:MT)) :-
MT is M1 + M2,
HT is H1 + H2,
MT < 60, !;
MT is (M1 + M2) - 60,
HT is (H1 + H2) + 1.

menorCaminhoTempo([Head1|Tail1], Distancia, [Head2|Tail2], Tempo) :-
menorCaminhoTempo(Tail1, Head1, Distancia, Tail2, Head2, Tempo).

menorCaminhoTempo([], Distancia, Distancia, [], Tempo, Tempo).
menorCaminhoTempo([Head1|Tail1],Distancia1, Distancia,[Head2|Tail2], Tempo1, Tempo) :-
mini(Head1, Distancia1, Distancia2, Head2, Tempo1, Tempo2),
menorCaminhoTempo(Tail1, Distancia2, Distancia, Tail2, Tempo2, Tempo).

mini(X1,X2,X1,Z1:Y1,Z2:Y2,Z1:Y1) :-
X1 = X2,
Z1 < Z2,
Y1 < Y2, !;
X1 = X2,
Z1 < Z2,
Y2 < Y1, !.
mini(X1,X2,X1,Z1:Y1,Z2:Y2,Z2:Y2) :-
X1 = X2,
Z2 < Z1,
Y1 < Y2, !;
X1 = X2,
Z2 < Z1,
Y2 < Y1, !.
mini(X1,X2,X1,Z1:Y1,Z2:Y2,Z1:Y1) :-
X1 = X2,
Z1 = Z2,
Y1 < Y2, !.
mini(X1,X2,X1,Z1:Y1,Z2:Y2,Z1:Y2) :-
X1 = X2,
Z1 = Z2,
Y2 < Y1, !.
mini(X1,X2,X1,Y1,_,Y1) :-
X1 < X2, !.
mini(X1,X2,X2,_,Y2,Y2) :-
X1 > X2.

%----------------------------------Exercicio_5------------------------------------

menorTempo(CidadeOrigem, CidadeDestino, Tempo) :-
findall(Tempo,menorTempoAux(CidadeOrigem,CidadeDestino,Tempo),Lista),
tempMin(Lista,Tempo).

menorTempoAux(CidadeOrigem, CidadeB, Tempo) :-
acesso(CidadeOrigem,CidadeB,_,_, Tempo).
menorTempoAux(CidadeOrigem,CidadeB, Tempo):-
acesso(CidadeOrigem,CidadeC,_,_,Tempo1),
menorTempoAux(CidadeC,CidadeB,Tempo2),
somandoMenorTempo(Tempo1,Tempo2,Tempo).

somandoMenorTempo((H1:M1),(H2:M2),(HT:MT)) :-
MT is M1 + M2,
HT is H1 + H2,
MT < 60, !;
MT is (M1 + M2) - 60,
HT is (H1 + H2) + 1.

tempMin([Head|Tail], Distancia) :-
tempMin(Tail, Head, Distancia).

tempMin([], Distancia, Distancia).
tempMin([Head|Tail], Distancia1, Distancia) :-
minimo(Head, Distancia1, Distancia2),
tempMin(Tail, Distancia2, Distancia).

minimo((H1:M1),(H2:_),(H1:M1)) :-
H1 < H2, !.
minimo((H1:_),(H2:M2),(H2:M2)) :-
H2 < H1, !.
minimo((H1:M1),(_:M2),(H1:M1)) :-
M1 < M2, !.
minimo((_:M1),(H2:M2),(H2:M2)) :-
M2 < M1, !.
minimo((H1:M1),(H2:M2),(H2:M2)) :-
H1 = H2,
M1 = M2.
