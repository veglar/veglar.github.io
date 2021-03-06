---
name: Masterkalender
image: /assets/img/2021/masterkalender_january.jpeg
permalink: /projekt/masterkalender
---
<a class="qlik-icon-edit-script"/>
# <a class="qicon-calendar"/> Masterkalender
Masterkalender är ett återanvändbart masterkalenderskript som kan hantera flera kalenderbehov. Den kan bland annat hantera följand scenarion.

- Ett datumfält en kalender
- Ett datumfält flera kalendrar (Eg. kalenderår och bokföringsår)
- Flera datumfält flera kalendrar
- Flera datumfält en kalender.

Masterkalenderskriptet består av tre SUB-funktioner som du kan läsa mer om nedan.

{% include elements/button.html link="#sub-kalender" text="SUB kalender" %}
{% include elements/button.html link="#sub-kalenderfrånfält" text="SUB kalenderfrånfält" %}
{% include elements/button.html link="#sub-kalenderlänk" text="SUB kalenderlänk" %}


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
Klistra in scriptet nedan i en qvs fil eller direkt i ditt applikationsskript för att använda de tre SUB som beskrivits ovan.

```qvs
SUB kalender (_minCalendarDate, _maxCalendarDate, _calendarKeyField, _calendarPrefix)
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
	* Använder @param3 _calendarKeyField, om ej definierat så används fältnamnet [%datum] .
	*/
	IF 	len(_calendarKeyField)>0 then
		SET _calendarKeyField = $(_calendarKeyField);
	ELSE
		SET _calendarKeyField = %datum;
	ENDIF 
	
	/* 
	* Skapar kalendertabell
	*/
	[$(_calendarPrefix)$(vL.kalender.tabellnamn)]:
	NOCONCATENATE LOAD      
			num( temporärdatum) 								as [$(_calendarKeyField)] ,
			Date(temporärdatum) 								as [$(_calendarPrefix)Datum],
			weekday(temporärdatum, $(FirstWeekDay)) 			as [$(_calendarPrefix)Veckodag],
			YearName(temporärdatum,0,$(FirstMonthOfYear)) 		as [$(_calendarPrefix)År],
			dual(week([temporärdatum],$(FirstWeekDay) ,$(BrokenWeeks),$(ReferenceDay)),
					  week(addmonths(temporärdatum,1-$(FirstMonthOfYear)),$(FirstWeekDay) ,$(BrokenWeeks),$(ReferenceDay))
					  ) 												as [$(_calendarPrefix)Vecka],
			DUAL(Month(temporärdatum) ,  
						num(Month(MonthName(temporärdatum, +1- $(FirstMonthOfYear))))
							)												as [$(_calendarPrefix)Månad],
			dual( date(MonthName(temporärdatum), '$(vL.kalender.aarmaanadformat)'),
						MonthStart(temporärdatum)) 					as [$(_calendarPrefix)År-månad],
			'Q'&Num(Ceil(Num(Month(temporärdatum))/3)) 		as [$(_calendarPrefix)Kvartal],
			Dual( 'Q'&Ceil(month(temporärdatum)/3) & ' ' &Year(temporärdatum), 
						num(QuarterStart(temporärdatum)) )  			as [$(_calendarPrefix)År-kvartal],
		if(temporärdatum  > '$(vL.kalender.idag)', 'Framtid', 'Historik') as [Historik/Framtid]
		;
	LOAD
				Date('$(_minCalendarDate)') + RecNo()-1 AS temporärdatum
		AUTOGENERATE 
				Date('$(_maxCalendarDate)') - Date('$(_minCalendarDate)') + 1;


	SET vL.SetModifier.CleanCalender = År, Månad, Datum, [År-månad],Veckodag,Vecka,Kvartal,År-kvartal, [Historik/Framtid];


	// Year To Date Modifier
	Let vL.SetModifier.YTD = 
	replace(
		'$(vL.SetModifier.CleanCalender),
				År=P({<$(vL.SetModifier.CleanCalender), Datum={''$1''}>}År),
				Datum = {"<=¤(=Date(''$1''))"}', 
		'¤', '$');	


	// Month 2 Date
	Let vL.SetModifier.Months2Date = 
	Replace(
		'$(vL.SetModifier.CleanCalender),
				Datum={">=¤(=date(rangemin(monthstart(''$1'',alt($2,0)),date(''$1''))))<=¤(=date(rangemax(monthend(''$1'',alt($2,0)),date(''$1''))))"}',
		'¤','$');	


	//Rensar upp lokala variabler
	LET vL.kalender.aarmaanadformat =;
	LET vL.kalender.tabellnamn =;
	LET _maxCalendarDate=;
	LET _minCalendarDate=;
ENDSUB  //Kalender

SUB kalenderfrånfält (vL.kalender.nyckelfält, _källa, _calendarPrefix)

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
	LET _maxCalendarDate = replace(peek('tempKalender.maxdatum'), ',', '.');
	LET _minCalendarDate = replace(peek('tempKalender.mindatum'), ',', '.');
	DROP table kalender.minmaxtabell;

	CALL kalender( '$(_minCalendarDate)','$(_maxCalendarDate)','$(vL.kalender.nyckelfält)', _calendarPrefix )
	LET _maxCalendarDate=;
	LET _minCalendarDate=;
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
		RESIDENT 
			[$(vL.kalender.faktatabell)]
    ;
ENDSUB
```




