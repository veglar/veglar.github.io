---
id: 181
title: Tool for extracting qvw variables into InQlik Tool syntax
date: 2014-11-11T19:22:35+01:00
guid: http://aqlik.se/?p=181
permalink: /2014/11/tool-for-extracting-qvw-variables-into-inqlik-tool-syntax/
format: aside
---
I got great response for my blogpost about <a href="{{ site.url }}{{ site.baseurl }}/2014/11/powerful-variable-editing-with-sublime-and-inqlik-tools"> Powerful variable editing with Sublime and inQlik tools</a>from earlier this week. I tought I should complement it with a simple but useful tool for extracting qvw expressions into InQlik YAML-like syntax.

It can be useful when you want to start working with external variables on applications that you already have developed with normal expressions.

## The expression extraction tool
The tool is an qvw that read out and format your expressions into the syntax used by the InQlik Tool for Sublime.
![Screenshot of the Export variable to InQlik Tool syntax application]({{ site.url }}{{ site.baseurl }}/assets/images/2014/11/ExportVariable2InQlikTool.png)
I extract the expressions using the following script:

`Expression:`   
`LOAD`   
`'vL.Expression_' & AutoNumberHash256(Definition,Label,Comment) as Expression,`    
`ObjectId,`     
`Definition,`    
`Label,`     
`Comment`     
`FROM`    
`[your.qvw]`    
`(XmlSimple, Table is [DocumentSummary/Expression]);`    

Feel free to download and use this tool. Please drop me a comment if you find it handy. Download the application: <a href="https://drive.google.com/file/d/0B5tB2ixIYVKbbFYzQUllNUtjY2M/view?usp=sharing">the expression extract tool</a>