---
id: 169
title: Powerful variable editing with Sublime and inQlik tools
date: 2014-11-10T10:01:03+01:00
guid: http://aqlik.se/?p=169
permalink: /2014/11/powerful-variable-editing-with-sublime-and-inqlik-tools/
---
<blockquote>Swedish version::   <a href="{{ site.url }}{{ site.baseurl }}/2014/11/kraftfull-variabel-hantering-med-inqlik-tools/">Kraftfull variabel-hantering med InQlik Tools</a></blockquote>
Centralized expression handling is a topic that rise in an organization when their QlikView environment matures. There are many reasons why one wants to move expressions and variables from individual QlikView documents into a centralized location. Often it's about ensuring that a single kpi is calculated in the same manner for all graphs and tables in all QlikView applications. When its time to edit a kpi calculation then the  change will only need to be done at a central location and not in every object that uses it. The objects refers to this variable instead of using the hard coded expression. This increases quality and reduces time needed to implement the changes. In other scenarios it is the need to let other parts of the organization take ownership and responsibility for the kpi and calculation logic, not IT.

The use of external variables may also speed up your environment  by increasing the use of the QlikView and Qlik Sense cache. The cache will only be reused when two identical written expressions are used, but with small diffrences between expressions the cache breaks. Read the Qlik DesignBlog - <a class="font-color-normal" href="http://community.qlik.com/blogs/qlikviewdesignblog/2014/04/14/the-qlikview-cache">The QlikView Cache</a> to get better insights.

I have seen several creative ways to lift out QlikView expressions from documents into a central place.  I'm guilty of several of those solutions. I get the feeling that each developer or development team have their own method for handling this issue. The main principle and the desired result is always the same, expressions and variables are stored centrally and used by QlikView on across multiple applications.
<h2>The Qlik Variable Standard</h2>
In QlikView Deployment Framework (QDF), there is a, by Qlik, recommended standard for variable handeling. It contains both a suggested name standards together with a methodology and support for external variable handling. By using the <em>Deployment Framework Editor</em> you can create and manage variablefiles that by easy means can be imported into a QlikView document using the sub 'LoadVariableCSV' that is included in the framework.

<img class="alignnone wp-image-152 size-large" src="{{ site.url }}{{ site.baseurl }}/assets/images/2014/11/Global_Variable_Editor_1_4_1.png" alt="Global_Variable_Editor_1_4_1" />

Management and manipulation of the QDF variable files are a feature in the Deployment Framework Editor interface. This interface is sufficient during maintainance and overview, but for my frequent use ande edits use during the development phase I've found a better alternative.
<h2 id="inqlik-expression-editor">InQlik expression editor for Sublime</h2>
InQlik expression editor is part of the open source project InQlik Tools, an add-on package to Sublime Text.
<ul>
	<li><a href="https://github.com/inqlik/inqlik-tools">Tools InQlik</a></li>
	<li><a href="http://sublimetext.com/">Sublime text</a></li>
</ul>
Using InQlik tools variables are written with a simplified YAML-like syntax in the Sublime Text editor.  In addition to saving the YAML-like document  InQlik Tools also saves a copy of the expressions into a QDF compatible variable file.
<pre>---
<span style="color: #666699;">set</span>:<span style="color: #ff6600;">vL.Income</span>
<span style="color: #666699;">definition</span>:<span style="color: #ff6600;">sum(</span>income<span style="color: #ff6600;">)</span>
<span style="color: #666699;">label</span>:<span style="color: #008000;">Income</span>
<span style="color: #666699;">comment</span>:<span style="color: #008000;">Total income.</span> 
---</pre>
This syntax feels natural and easy, compared to a csv-file. I feel more effective in my work working this way compared to editing the csv directly or using the QlikView Framework Editor. The output of the YAML-like syntax above will result in a csv  like the text below:
<pre>Variable Name, Variable Value, Comments, Priority 
SET vIncome, sum (income) ,, 
SET vIncome.Comment, total income. ,, 
SET vIncome.Label, Income ,,</pre>
It is possible to change output from csv to native QlikView script code (qvs), for those who are not using the QDF but want a centralized variable handling. The native qvs-file can be inluded into the script either by include or just copy-paste of thest,  as the qvs result looks like this:

```
SET vIncome = sum(income);
SET vIncome.Comment = Total income.;
SET vIncome.Label = Income;
```

<h2>Dollar expansion</h2>
<img class="alignnone wp-image-146 size-full" src="{{ site.url }}{{ site.baseurl }}/assets/images/2014/11/Scalextric_2.jpg" alt="Scalextric_2" width="300" height="223" />

In my own previous attempts in handling external variables i often wrestled with expressions using dollar expansions. QDF-handles this great, but also the inQlik tools qvs exports handles this with seemingly without any problems.
<pre>---
<span style="color: #666699;">set</span>:<span style="color: #ff6600;">vL.sumDynExp</span>
<span style="color: #666699;">definition</span>:<span style="color: #ff6600;">sum([</span>$(=DynExp)]<span style="color: #ff6600;">)</span>
<span style="color: #666699;">---</span></pre>
The  expression declaration above will result in the native qvs variable declaration as written below. Notice how it handles the dollar ($) problem.

`let vL.sumDynExp= replace(replace('sum([@(=DynExp)])','~~~', 'chr(39)'), '@(', chr(36) &amp; '(');`

<h2>Reference to other variables</h2>
InQlik expression editor are able to do something that  neither QlikView Framework editor, notepad or excel can do without carrying out a small development projects in advance. When using InQlik variable declaration you are able to refere to other variables and during export to qdf-csv or qvs expand thes references such that the referenced declarations is exported.

In the example below, I let the third expression be declared with references to the two prior.
<pre>--- 
Set: vL.income 
definition: sum ([income]) 
--- 
sets: vL.expense 
definition: sum ([Expense]) 
--- 
sets: vL.profit 
definition: $ (vL.income) - $ (vL.expense) 
---</pre>
By letting InQlik tool expand the variables during export I get  vL.Profit saved as <code>sum ([income]) - sum ([Expense])</code> . No more manual tracing down multiple layers of referenced variables when tracking down a bug!

<h2>Summary</h2>
Centralized expression handling has several advantages, both in terms of management, accountability. It can also be benificial in terms of system speed and utalization of the QlikView global cache.

Qlik are pointing all developers in the same direction with the introduction of a standard variable naming and handling. I think that this standard will fill the needs found in many scenarios when it comes to variable handling and expression centralization. I see no reason not to start using the QDF standard format for handling variables unless you already have invested in other methologies. It is an easy and open standard.

I prefer creating variable files using InQlik on Sublime, but you could easily use another system or stick to the Deployment Framework Editor that is shipped with the QDF. The reason I enjoy inQlik variable editor is the possibility to in a efficient way build and reuse expressions. The declaration syntax is easy to write and read and I use the same syntax whether I choose to export to qdf format or plain qvs script.