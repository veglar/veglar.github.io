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

```qve
{% include sublib/data_load_script/sublib.kalender.qvs %}
```