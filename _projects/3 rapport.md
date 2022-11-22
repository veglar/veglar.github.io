---
name: Rapport
image: /assets/img/2022/Brown_Chop_Logs_on_Outdoor.jpg
permalink: /projekt/rapport
---

# <a class="qicon-data-load"/> Rapport
Sublib Rapport är en sub som jag använder för att på ett snabbt sätt kunna skapa en rapporttabell som kopplar rubrik till ett urval konton (eller annat numerisk nycke). Typiska användsingområden är att skapa resultaträkning, balansräkning eller annan kpi-rapport.

I sin enklaste form kan sub rapport användas för att koppla ett konto till en rubrik, men det finns även stöd för överlappande rubriker. T.ex. konton kopplas till materialkostnader eller personalkostnader, men även den överggripande rubriken  _kostnader_ samt bidra i beräkningen av "täckningsbidraget".

Det finns också stöd i sub rapport för att kunna beräkna kvoter av grupperingar, t.ex. beräkna kvoten av teckningsbidrag och omsättning för att få täckingsgrad.

SUB rapport används såhär
1. Ladda datamodell med kontonummer 
2. Skapa en rapport-tabell
3. Anrop SUB med parametrar
    1. Namnet på rapporttabell
    2. Fältnamnet som rapporten kopplar på (numerisk)
    3. Vilket grupp som avses

```qvs
{% include sublib/data_load_script/sublib.rapport.test.qvs %}
```

```qvs
{% include sublib/data_load_script/sublib.rapport.qvs %}
```
