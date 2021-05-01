---
name: Masterkalender
image: /assets/img/2021/masterkalender_january.jpeg
permalink: /projekt/masterkalender
---
<a class="qlik-icon-edit-script"/>
# <a class="qicon-calendar"/> Masterkalender
*En gångbar masterkalender som består av tre olika SUB.*

* [SUB kalender](#sub-kalender) 
* [SUB kalenderfrånfält](#sub-kalenderfrånfält)
* [SUB kalenderlänk](#sub-kalenderlänk)

### SUB kalender
Innhåller koden för själva kalendern. Skapar en masterkalender med hjälp av 2-4 parametrar.
   
#### Parametrar
1. [obligatorisk] Första datum i kalendern. 
2. [obligatorisk] Sista datum i kalendern
3. [valfri] Nyckelfältnamn i kalendern.
4. [valfri] Kalender-prefix

#### Exempler på anrop

```qve 
/* 1. Skapa en kalender med default nyckelfält*/	
	CALL kalender('2020-01-01', '2021-12-31')

/* 2. Skapa en kalender med nyckelfält som heter '%DateID'*/ 
	CALL kalender('2020-01-01', '2021-12-31', '%DateID')

/* 3. Skapa en Kalender där kalenderfälten har prefixet  'Leverans-'.*/ 
	CALL kalender('2020-01-01', '2021-12-31', '', 'Leverans-')
```

Alla dessa anrop skapar en kalender som innehåller följande fält, med undantag av anrop 3 där alla kalenderfältnamnm har prefixet leverans-. 

| Fält            | Kommentar|
| --------------- | ----------|
| Datum           | Formaterad som angett i systemvariabeln `DateFormat`.
| Veckodag		  | Veckodag, första veckodag styrs av systemvariabel [_FirstWeekDay_](https://help.qlik.com/sv-SE/qlikview/April2019/Subsystems/Client/Content/QV_QlikView/Scripting/NumberInterpretationVariables/FirstWeekDay.htm). |
| Vecka   	      | Veckonummer, presenteras med veckonummer där januari är årets första månad, men sorteras utifrån vad som är årets första månad via systemvariabeln [_FirstMonthOfYear_](https://help.qlik.com/en-US/qlikview/April2019/Subsystems/Client/Content/QV_QlikView/Scripting/NumberInterpretationVariables/FirstMonthOfYear.htm). Fältet påverkas också av systemvariablerna [_FirstWeekDay_](https://help.qlik.com/sv-SE/qlikview/April2019/Subsystems/Client/Content/QV_QlikView/Scripting/NumberInterpretationVariables/FirstWeekDay.htm), [_BrokenWeeks_](https://help.qlik.com/en-US/qlikview/April2019/Subsystems/Client/Content/QV_QlikView/Scripting/NumberInterpretationVariables/BrokenWeeks.htm) och [_ReferenceDay_](https://help.qlik.com/en-US/qlikview/April2019/Subsystems/Client/Content/QV_QlikView/Scripting/NumberInterpretationVariables/ReferenceDay.htm).
| År              | Formaterad som _YYYY_, fast med numersikt värde satt till årets första dag. Årets indelning styrs av systemvariabeln [_FirstMonthOfYear_](https://help.qlik.com/en-US/qlikview/April2019/Subsystems/Client/Content/QV_QlikView/Scripting/NumberInterpretationVariables/FirstMonthOfYear.htm)|
| Månad           | Formaterad som angett i systemvariabeln `MonthNames`.
| År-månad        | Formaterad som angett i variabeln `vL.kalender.aarmaanadformat`.
| Kvartal         | 'Q1', 'Q2', 'Q3' eller 'Q4'
| År-kvartal      | Formaterad som '_YYYY_ Q1', '_YYYY_ Q2', '_YYYY_ Q3' eller '_YYYY_ Q4' och med kvartalets första datum som numeriskt värde.|
| Historik/Framtid| Har värdet 'Historik' för alla historiska datum och  'Framtid' för alla framtida datum. Brytpunkten är per default `Today()`, men kan overridas med variabeln `vL.kalender.idag`.

### SUB kalenderfrånfält
Ett förenklad anropssätt för att skapa en kalender utifrån ett redan inläst kalenderfält. Funktionen hittar minsta och största värdet i angett kalenderfät och anropar SUB kalender med de värdena.

1. [obligatorisk] Kalendernyckelfält. Det fält som det ska kopplas en kalender på.
2. [valfri] Källa som innehåller pinpointar kalenderfältets källa. 
4. [valfri] Kalender-prefix




### SUB kalenderlänk
Metod för att koppla flera datumfält i en tabell till en och samma masterkalender. 

### Masterkalender.qvs

```qvs
SUB kalender (_minstaKalenderdatum, _störstaKalenderdatum, _kalendernyckelfalt, _kalendernamn)
/**
Skapa kalender från ett min och max-datum
@Param 1 Obligatoriskt. [Minsta kalenderdatum] Det datum där kalendern ska börja.
@Param 2 Obligatoriskt. Det datum kalendern sk sluta
@Param 3 Valfri. Namn på nyckelfält som inehåller heltalsrepresentationen av kalenderdagen.
@Param 4 Valfri. Ett prefix som identifierer både kalendertabell och fältnamn. Default är <blank>
@variable IN vL.kalender.aarmaanadformat Det format som År-månad-fältet ska presenteras i. Default='YYYY MMM'.
@variable IN vL.kalender.tabellnamn Namn på kalendertabell. Evt. prefix angett som @param 4 tillkommer i slutgiltig tabellnam.
@variable IN vL.kalender.idag Brytpunkt mellan historik och framtid.  Default=today().

*/
	/*
	* Konfigurering av kalenderparametrar
	*/
	LET vL.kalender.aarmaanadformat = if(len('$(vL.kalender.aarmaanadformat)')=0, 'YYYY MMM', vL.kalender.aarmaanadformat);
	LET vL.kalender.tabellnamn = if(len('$(vL.kalender.tabellnamn)')=0, 'Kalender', vL.kalender.tabellnamn);
	LET vL.kalender.idag= if(len('$(vL.kalender.idag)')=0, today(), date('$(vL.kalender.idag)'));
	LET FirstMonthOfYear= if(len('$(FirstMonthOfYear)')=0, 1, FirstMonthOfYear);
    LET ReferenceDay= if(len('$(ReferenceDay)')=0, 1, ReferenceDay);
    LET BrokenWeeks= if(len('$(BrokenWeeks)')=0, 1, BrokenWeeks);
    LET FirstWeekDay= if(len('$(FirstWeekDay)')=0, 1, FirstWeekDay);
	/*
	* Stadfäster nyckelfält i kalendern. 
	* Använder @param3 _kalendernyckelfalt, om ej definierat så används fältnamnet [%datum] .
	*/
	IF 	len(_kalendernyckelfalt)>0 then
		SET _kalendernyckelfalt = $(_kalendernyckelfalt);
	ELSE
		SET _kalendernyckelfalt = %datum;
	ENDIF 
	
	/* 
	* Skapar kalendertabell
	*/
	[$(_kalendernamn)$(vL.kalender.tabellnamn)]:
	NOCONCATENATE
	LOAD
		num(temporärdatum) AS [$(_kalendernyckelfalt)] ,
		Date(temporärdatum) as [$(_kalendernamn)Datum],
        weekday(temporärdatum, $(FirstWeekDay)) as [$(_kalendernamn)Veckodag],
		YearName(temporärdatum,0,$(FirstMonthOfYear)) as [$(_kalendernamn)År],
		dual( 
        	week([temporärdatum],$(FirstWeekDay) ,$(BrokenWeeks),$(ReferenceDay)),
            week(addmonths(temporärdatum,1-$(FirstMonthOfYear)),$(FirstWeekDay) ,$(BrokenWeeks),$(ReferenceDay))
            ) as [$(_kalendernamn)Vecka],
        DUAL(Month(temporärdatum) ,  num(Month(MonthName(temporärdatum, +1- $(FirstMonthOfYear))))) as [$(_kalendernamn)Månad],
		dual(	date(MonthName(temporärdatum), '$(vL.kalender.aarmaanadformat)'),
				MonthStart(temporärdatum)
			) AS [$(_kalendernamn)År-månad],
		'Q'&Num(Ceil(Num(Month(temporärdatum))/3)) as [$(_kalendernamn)Kvartal],
		Dual(	'Q'&Ceil(month(temporärdatum)/3) & ' ' &Year(temporärdatum), 
				num(QuarterStart(temporärdatum))
			)  as [$(_kalendernamn)År-kvartal],
		if(temporärdatum  > '$(vL.kalender.idag)', 'Framtid', 'Historik') as [Historik/Framtid]
		;
	LOAD
		Date('$(_minstaKalenderdatum)') + RecNo()-1 AS temporärdatum
	AUTOGENERATE
		Date('$(_störstaKalenderdatum)') - Date('$(_minstaKalenderdatum)') + 1;


	//Rensar upp lokala variabler
	LET vL.kalender.aarmaanadformat =;
	LET vL.kalender.tabellnamn =;
	LET _störstaKalenderdatum=;
	LET _minstaKalenderdatum=;
ENDSUB  //Kalender

SUB kalenderfrånfält (vL.kalender.nyckelfält, _källa, _kalendernamn)

	// Ta reda på om minmax ska hämtas från specifik resident-tabell, qvd eller textfil.
	IF len('$(_källa)')=0 THEN
		SET vL.kalender.minmaxkälla = ";LOAD FieldValue('$(vL.kalender.nyckelfält)', recno()) as [$(vL.kalender.nyckelfält)] 
										AUTOGENERATE FieldValueCount('$(vL.kalender.nyckelfält)')";
	ELSEIF index('$(_källa)', '.') = 0 THEN
		SET vL.kalender.minmaxkälla = 'RESIDENT $(_källa)';
	ELSEIF '.qvd' = lower(right('$(_källa)', 4)) THEN
		SET vL.kalender.minmaxkälla = 'FROM $(_källa) (qvd)';
	ELSE
		SET vL.kalender.minmaxkälla = 'FROM $(_källa)';	// Assume text file
	ENDIF

	kalender.minmaxtabell:
	LOAD
		max([$(vL.kalender.nyckelfält)])+0 as tempKalender.maxdatum,
		min([$(vL.kalender.nyckelfält)])+0 as tempKalender.mindatum	
	$(vL.kalender.minmaxkälla);

	LET vL.kalender.minmaxkälla =;
	// Byter ut europeisk decimalseperator  ',' så att qlikview förstår att det är ett värde.
	LET _störstaKalenderdatum = replace(peek('tempKalender.maxdatum'), ',', '.');
	LET _minstaKalenderdatum = replace(peek('tempKalender.mindatum'), ',', '.');
	DROP table kalender.minmaxtabell;

	CALL kalender( '$(_minstaKalenderdatum)','$(_störstaKalenderdatum)','$(vL.kalender.nyckelfält)', _kalendernamn )
	LET _störstaKalenderdatum=;
	LET _minstaKalenderdatum=;
ENDSUB

SUB kalenderlänk(vL.kalender.faktatabell, vL.kalender.datumfält, vL.kalender.datumnyckel, vL.kalender.linkID)
/**
Skapar länkkalender med fälten, 
[Fält som ska kopplas mot Fakta] - @Param 4
[Typ av datum] 	- fälten som skickas in i @Param 2 ex ([Fält 1], [Fält 2], [Fält 3]
[Länkfält till kalender] - @Param 3

@syntax CALL kalenderlänk(vL.kalender.faktatabell, vL.kalender.datumfält, vL.kalender.datumnyckel, _RowId)
@Syntax CALL kalenderlänk('Fact','[Date (Booking)], [Date (Start)]','%DateKey','TransactionID');
@Param 1 Tabell som innehåller fakta/transaktionsmängd, exempel "Fact"
@Param 2 Kommaseparerad lista med fält som skall tas från Fact/Transaction för att generera upp länkkalender. 
		 Fältnamnen blir värden i "Kalender", exempel "Date1, Date2, Date3".
@Param 3 Fältnamn som skall kopplas mot masterkalender - exempel, "%DateKey"
@Param 4 Fältnamn som skall kopplas mot fakta/transaktionsmängd, exempel "TransactionID"

*/
    [Kalenderlänk]:
    CROSSTABLE([Kalender], $(vL.kalender.datumnyckel), 1)
    LOAD DISTINCT
       $(vL.kalender.linkID),
       $(vL.kalender.datumfält)
    RESIDENT [$(vL.kalender.faktatabell)]
    ;
ENDSUB
```