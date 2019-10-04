team(
	club_brugge;monaco;paris_saint_germain;olympic_lione;
	borussia_dortmund;schalke_04;bayern_monaco;hoffenheim;
	aek;tottenham_hotspur;liverpool;manchester_city;
	manchester_united;inter;napoli;roma;
	juventus;psv_eindhoven;ajax;porto;
	benfica;viktoria_plzen;lokomotiv_mosca;cska_mosca;
	stella_rossa;atletico_madrid;barcellona;real_madrid;
	valencia;young_boys;galatasaray;shakhtar_donetsk
).

country(belgio;francia;germania;grecia;inghilterra;italia;olanda;portogallo;repubblica_ceca;russia;serbia;spagna;svizzera;turchia;ucraina).

city(
	bruges;monaco;parigi;lione;
	dortmund;gelsenkirchen;monaco_di_baviera;
	hoffenheim_sinsheim;atene;londra;liverpool;
	manchester;milano;napoli;roma;
	torino;eindhoven;amsterdam;porto;
	lisbona;plzen;mosca;belgrado;
	madrid;barcellona;valencia;berna;
	istanbul;donetsk
).

group(a;b;c;d;e;f;g;h).
% group(a;b).

club(club_brugge,belgio,bruges).
club(monaco,francia,monaco).
club(paris_saint_germain,francia,parigi).
club(olympic_lione,francia,lione).
club(borussia_dortmund,germania,dortmund).
club(schalke_04,germania,gelsenkirchen).
club(bayern_monaco,germania,monaco_di_baviera).
club(hoffenheim,germania,hoffenheim_sinsheim).
club(aek,grecia,atene).
club(tottenham_hotspur,inghilterra,londra).
club(liverpool,inghilterra,liverpool).
club(manchester_city,inghilterra,manchester).
club(manchester_united,inghilterra,manchester).
club(inter,italia,milano).
club(napoli,italia,napoli).
club(roma,italia,roma).
club(juventus,italia,torino).
club(psv_eindhoven,olanda,eindhoven).
club(ajax,olanda,amsterdam).
club(porto,portogallo,porto).
club(benfica,portogallo,lisbona).
club(viktoria_plzen,repubblica_ceca,plzen).
club(lokomotiv_mosca,russia,mosca).
club(cska_mosca,russia,mosca).
club(stella_rossa,serbia,belgrado).
club(atletico_madrid,spagna,madrid).
club(barcellona,spagna,barcellona).
club(real_madrid,spagna,madrid).
club(valencia,spagna,valencia).
club(young_boys,svizzera,berna).
club(galatasaray,turchia,istanbul).
club(shakhtar_donetsk,ucraina,donetsk).


giornata(1..6).
% giornata(1).

% ************ CREAZIONE GIRONE ************ %

% Ogni girone deve essere composto da 4 team
4 {assegna(Team, Group) : team(Team)} 4 :- group(Group).


% VINCOLI

same_nation(Team1, Team2) :-
	club(Team1,Nation1,_),
	club(Team2,Nation2,_),
	Nation1 == Nation2.
	

% Non possono esistere due assegnamenti in uno stesso gruppo dove i due team sono della stessa nazione
:- assegna(Team1,Group1), assegna(Team2,Group2), same_nation(Team1,Team2), Team1 != Team2, Group1 == Group2.

% Non possono esistere due assegnamenti diversi con lo stesso team in gruppi diversi
:- assegna(Team1,Group1), assegna(Team2,Group2), Group1 != Group2, Team1 == Team2.



% ************ CREAZIONE GIORNATE ************ %
16 {match(Team1, Team2, Giornata) : match_available(Team1, Team2)} 16 :- giornata(Giornata).

% 2 {match(Team1, Team2, Giornata) : match_available(Team1, Team2)} 2 :- group(Gruppo).

match_available(Team1, Team2) :-
	assegna(Team1, Girone1),
	assegna(Team2, Girone2),
	Girone1 == Girone2,
	Team1 != Team2.

:- match_available(Team1, Team2), not match(Team1, Team2, _).

% :- club(Team), match(Team, _, _).

% match(Team) :-
% 	match(Team, Team2, _).

% match(Team) :-
% 	match(Team1, Team, _).

% total(Total) :- Total = #count { team(Team) : match(Team, _, _) }.
% total(Total, Team1) :- Total = #count { match(Team1, Team2, Giornata) : giornata(Giornata), team(Team1), team(Team2) }.

% total(Team, Casa, FuoriCasa, Giornata, Full) :- 
% 	Casa = #count { Team2 : match(Team,Team2,Giornata)},
% 	FuoriCasa = #count { Team1 : match(Team1,Team,Giornata)},
% 	Full = #sum {Casa, FuoriCasa},
% 	team(Team),
% 	giornata(Giornata).

% :- total(Total), Total < 16.



% :- match(_, monaco, _).
% :- team(Team), match(Team, _,_).

% :- match(Team1, Team2, Giornata1), match(Team3, Team4, Giornata2), Giornata1 == Giornata2, Team1 == Team3. 

% already_scheduled(Team, Giornata) :-
% 	match(Team, Team1, Giornata).

% already_scheduled(Team, Giornata) :-
% 	match(Team1, Team, Giornata).

% :- already_scheduled(Team, Giornata).

% overlap(Team1) :-
% 	match(Team1, Team2, Giornata1),
% 	match(Team3, Team4, Giornata2),
% 	Giornata1 == Giornata2,
% 	Team1 == Team3.
	

% -match_available(Team1,Team2) :-
	% match(Team1, Team2, _).

% result(Team1, S) :- S = #count{ Team1 : match(Team1, Team2, Giornata)}, team(Team1).


% :- #count{Team2, Team1: match(Team1, Team2, G), match(Team1, Team2, G), G == G} = 1.

% result(S) :- S = #count{X:something_to_limit(X)}.

% -match_available(Team1, Team2) :-
% 	match_available(Team1, Team2).



% Equivale a mettere T1 != T2 nell'aggregato di sopra
% :- match(T1, T2, G), T1 == T2.

% Non può esistere che un compaia più di una volta in casa (o in trasferta) durante una giornata
% 2 {match(_,T,G); match(T,_,G)} perchè questa condizione sia soddissfatta (true) deve esistere un match con il club T in trasferta e un match con il club T in casa nella stessa giornata G
% :- club(T,_,_), 2 {match(_,T,G); match(T,_,G)}.



% COSA STAMPARE

% #hide.
% #show assegna(monaco, a).
% #show assegna/2.
% #show match/3.
% #show match/1.
#show total/5.
% #show result/2.
% #show match_available/2.






