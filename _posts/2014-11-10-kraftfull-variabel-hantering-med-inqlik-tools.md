---
id: 138
title: Kraftfull variabel-hantering med InQlik Tools
date: 2014-11-10T08:55:03+01:00
guid: http://aqlik.se/?p=138
permalink: /2014/11/kraftfull-variabel-hantering-med-inqlik-tools/

---
>English version: [Powerful variable editing with Sublime and InQlik Tools]({{ site.url }}{{ site.baseurl }}/2014/11/powerful-variable-editing-with-sublime-and-inqlik-tools/). 

Sentraliserad uttryckshantering är ett tema som ofta dyker upp allt efter som en QlikView mognar. Det finns många skäl till varför man önskar att lyfta ut uttryck och variabler ut från enskilda QlikView-dokument och till en central plats. Ofta handlar det om att säkerställa att man beräknar samma nyckeltal på samma sätt i alla grafer och tabeller i alla applikationer. När beräkningen ska justeras behövs den ändringen endast göras på en central plats och inte inne i varje objekt som använder det. Detta höjer kvaliteten och minskar förvaltningstid. Andra gånger handlar det om att lyfta ansvaret för affärslogiken från utvecklarna och ut till verksamheten.

Du kan också reducera cpu belastningen i en QlikView server med hjälp av central uttryckshantering. QlikViews globala cache gör så att två identiska utryck kan återanvända varandras resultat genom att resultat sparas ned temporärt. Kravet är att uttrycken måste vara identiskt skrivna, bö den minsta skillnad bryter återanvändningen. Du kan läsa mer om QlikView Global Cache i Qlik DesignBlog - [The QlikView Cache](http://community.qlik.com/blogs/qlikviewdesignblog/2014/04/14/the-qlikview-cache).

Jag har sett flera kreativa sätt att lyfta ut uttrycken på, jag är skyldig till flera av de. Känslan är att varje utvecklare eller utvecklargrupp har sin egen metod. Principen och önskar resultat är dock alltid det samma, uttryck och variabler sparas centralt och används av QlikView på tvärrs av applikationer.
<h2>Ny standard för variabler</h2>
I QlikView Deployment Framework (QDF) så finns en, av Qlik, rekommenderad standard för variabler. Den innehåller både förslag på namnstandarder samt metod och stöd för extern variabelhantering. Med hjälp av Deployment Framework Editor kan man skapa och hantera variabelfiler som kan på ett enkelt sätt används av QlikView med hjälp av en sub ´LoadVariableCSV´ som ingår i ramverket.

![Global_Variable_Editor_1_4_1]({{ site.url }}{{ site.baseurl }}/assets/images/2014/11/Global_Variable_Editor_1_4_1.png)


Gränssnittet i Deployment Framework Editor erbjuder stöd för hantering och manipulering av QDF-variabelfiler (som är kommaseparerade csv-filer). Det gränssnittet fungerar bra för enkla justeringar och förvaltning, men för daglig använding tycker jag det finns ett bättre alternativ.
<h2 id="inqlik-expression-editor">InQlik expression editor</h2>
InQlik expression editor är en del av det öppna källkodsprojektet InQlik Tools, ett tilläggspaket till Sublime Text.
<ul>
	<li><a href="https://github.com/inqlik/inqlik-tools">InQlik Tools</a></li>
	<li><a href="http://sublimetext.com">Sublime text</a></li>
</ul>
Variabler skrivs med en förenklad YAML-lik syntax i Sublime text och paketeras sedan av InQlik Tools till en QDF kompatibel variabelfil.
<pre>---
<span style="color: #666699;">set</span>:<span style="color: #ff6600;">vL.Income</span>
<span style="color: #666699;">definition</span>:<span style="color: #ff6600;">sum(</span>income<span style="color: #ff6600;">)</span>
<span style="color: #666699;">label</span>:<span style="color: #008000;">Income</span>
<span style="color: #666699;">comment</span>:<span style="color: #008000;">Total income.</span> 
---</pre>
Jag tycker detta sättet att skriva uttryck på blir mer översiktligt än om jag skulle jobba direkt i en QDF-csv fil som ser ut som nedan.
<pre>VariableName,VariableValue,Comments,Priority
 SET vIncome,sum(income),,
 SET vIncome.Comment,Total income.,,
 SET vIncome.Label,Income,,</pre>
Den som inte önskar att använda QDF-funktionen för att hantera variabler finns även möjligheten att spara ned filen som qvs-kod. Då ser resultatet ut såhär:

```qlikview 
SET vIncome = sum(income);
SET vIncome.Comment = Total income.;
SET vIncome.Label = Income;
```
<h2>Dollar expansion</h2>
![Scalextric_2]({{ site.url }}{{ site.baseurl }}/assets/images/2014/11/Scalextric_2.jpg)

I mina egna tidigare lösningar på extern variabelhantering så brottades jag ofta brottats dollar-expansioner. QDF-hanterar detta jättebra, men även qvs-exporten hanterar detta med glans.
<pre>---
<span style="color: #666699;">set</span>:<span style="color: #ff6600;">vL.sumDynExp</span>
<span style="color: #666699;">definition</span>:<span style="color: #ff6600;">sum([</span>$(=DynExp)]<span style="color: #ff6600;">)</span>
<span style="color: #666699;">---</span></pre>
Resulterar i en qvs-definition som ser ut som följande

`let vL.sumDynExp= replace(replace('sum([@(=DynExp)])','~~~', 'chr(39)'), '@(', chr(36) &amp; '(');`

Definitionen ovan genererar utan $-tolkningsproblem en variabel som ser ut precis som jag har angav i YAML-uttrycket.

<h2>Referens till andra variabler</h2>

InQlik expression editor kan något som värken QlikView Framework Editor, notepad eller excel kan göra utan att genomföra ett mindre utvecklingsprojekt innan. I variabeldeklareringen kan du referera till andra variabler.

I exemplet nedan låter jag det tredje uttrycket referera till de två första.

<pre>---
set:vL.income
definition:sum([income])
---
set:vL.expense
definition:sum([expense])
---
set: vL.profit
definition:$(vL.income)-$(vL.expense) 
---</pre>

Jag kan nu välja om jag vill spara vL.profit som

`$(vL.income)-$(vL.expense)`

eller låta InQlik tool expandera variablerna så att vL.Profit sparas som

`sum([income])-sum([expense])`.

Jag upplever att detta ökar transparansen i variablerna som laddas in i QlikView samtidigt som jag inter behöver återkskapa samma uttryck flera gånger manuellt.

## Summering

Central uttrykshantering har flera fördelar, båda när det gäller förvaltning, ansvar och även rent teknsik då indentisk skrivna uttryck kan återanvända QlikViews cache på ätt bättre sätt an uttryck som inte är helt identiska.

Qlik frontar nu en standard via QDF, en standard som jag tycker fungerar bra. Variabel-editorn som följer med får dock se sig slagen av möjligheterna som erbjuds i InQlik Tool for Sublime Text. Med InQlik Tools kan man dessutom skriva samma syntax för att använda central variabelhantering i miljöer som inte använder QDF.