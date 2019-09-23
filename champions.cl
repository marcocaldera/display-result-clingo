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


4 {assegna(T, G) : team(T)} 4 :- group(G).




% VINCOLI

% Non possono esistere due assegnamenti in uno stesso gruppo dove i due tem sono della stessa nazione
:- assegna(T1,G1), assegna(T2,G2), G1 == G2, club(T1,N1,_), club(T2,N2,_), N1 == N2, T1 != T2.

% Non possono esistere due assegnamenti diversi con lo stesso team in gruppi diversi
:- assegna(T1,G1), assegna(T2,G2), G1 != G2, T1 == T2.




% COSA STAMPARE

#show assegna/2.






