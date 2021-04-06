---
title: Sublime for Qlik development in 9 steps
date: 2017-01-21T21:37:47+01:00
permalink: /2017/01/sublime-for-qlik-development-in-8-steps/
classes: wide

---
When developing QlikView and Qlik Sense scripts I prefer to use Sublime for scripting over the built in script editors. I have found separating script and layout to be a good idea partly because it enables me to run scripts in both QlikView and in Qlik Sense, partly because it is easier to handle when using version control such as GIT and partly because it makes it easier to separate the script and the layout development between individuals.

Sublime is an excellent text editor tool that have a lot of possiblilties in regards of tweaking and customizing. To get it as Qlik effective as possible for my needs I usually customize it a bit. In this blogpost I will describe to you how I set up Sublime when I enter a new development environment.

### 1. Sublime
Get your own copy of [Sublime 3](https://www.sublimetext.com/3) and install it on your computer. It is available as a normal installation and as a portable version, my adjustments further down this post will work on both instances. I tend to choose the normal installation wherever I am allowed to do normal installations and use the portable version where I am not.

![Sublime 3 editor]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01/Sublime_Editor.png)

Sublime is free to try, but if you continue using it you are obliged to phurchase a license. The licensing model is one license per user and not per machine. This licensing model is benificial for me as a multi site developer, I only need my single license to work on all my clients Qlik environments.

### 2. Package Control
Package Control is a Sublime extension manager that makes it easy to do installations, updates and removal of a wide range collection of extensions.

![Package Control Stats]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01/PackageControl-1024x380.png "Screen shot of the packagecontrol.io statistics jan 24 2017")

I always start of my Sublime custimisation  by installing this extension. I keep it simple by installing by using the _Simple_ method, opening the Sublime console and paste the block of text described in the [Package Control Installation](https://packagecontrol.io/installation#st3) page.

![Show Console]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01/Sublime_Show_Console.png "Show Sublime 3 Console")
![Console]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01/Sublime_Console.png "Sublime 3 Console")
### 3. InQlik Tools
InQlik is a fantastic plugin for Sublime if you developing QlikView or Qlik Sense. It contains a set of tools  for QlikView development but it also highly compatible with Qlik Sense scripting. InQlik Tools was the deal breaker for me, it's what made me switch from notepad++ and QlikView desktop client scripting.

#### Highlighting
InQlik provides Qlik script highlighting and type ahead. It does also support syntax highlighting for QlikView log files that really helps when examining QlikView log-files.

Below is an example on how a piece of qvs script will change with the syntax highlighting.

![Comparison with and without highlighting activated]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01\InQlik_with_without_highlighting.png "Comparison with and without highlighting activated")

#### QVD meta data
Another great featur is the QVD meta data viewer that generate a plain test metadata presentation when you click on a QVD file. It provides the followin information

+ QVD creation time
+ Field names in the QVD
+ Number of unique values per  field
+ Memory usage per field

It also generate a sample load statement that you can copy and paste into your script.

**Example (Customers.qvd):**     
```markdown
Customers.MD
---

91 records. QVD created at 2016-08-12 09:32:45

### Fields:
- **CustomerID**. Unique values: 91, Memory usage: 637
- **CompanyName**. Unique values: 91, Memory usage: 1925
- **ContactName**. Unique values: 91, Memory usage: 1463
- **ContactTitle**. Unique values: 12, Memory usage: 237
- **City**. Unique values: 69, Memory usage: 689
- **PostalCode**. Unique values: 85, Memory usage: 893
- **Country**. Unique values: 21, Memory usage: 178


#### Sample load statement:
[QlikView]
LOAD
 CustomerID,
 CompanyName,
 ContactName,
 ContactTitle,
 City,
 PostalCode,
 Country,
 FROM [C:\Qlik\Exercises\1.Example\2.QVD\Customers.qvd] (QVD);
``` 


I do also use [EasyQlik QViewer](http://easyqlik.com/index.html) as a qvd-tool, but I find InQlik Tools much faster for just this tas, especially when I already have Sublime up and running with a mounted folder  with qvds in my sidebar.

#### Variable handling
![InQlik Variable Tool]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01/InQlik_variabletool_source.png)

Thirdly the plugin includes an YAML like language plugin for generating variables. The output is plain Qlik script-code the csv format used by the Qlik Deployment Framework (QDF).

![InQlik Variable Tool]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01/InQlik_variabletool_output_qdf_csv.png) ![InQlik Variable Tool]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01/InQlik_variabletool_output_qvs.png)

You can read more about the InQlik tool plugin at [GitHub - inqlik/inqlik-tools](https://github.com/inqlik/inqlik-tools).

InQlik Tools is available through the Package Control. If Package Control is installed then just type `Ctrl-Shift-P`{: .btn} and then start typing `Install package` untill you see the Package Control: Install Package in your drop down menu.
![Package control install]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01/Packagecontrol_install_package.png)
![Package control install inqlik_tools]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01/Packagecontrol_install_inqlik_tools.png "Packagecontrol - install InQlik Tools")

Press enter when InQlik-Tools occur and the Package Control handles the installation for you.

### 4. Advanced CSV
I often run into csv-files in my Qlik development. I tend to choose csv-over over Excel when create supporting tables manually. CSV is plain text and it is not necessary to install Excel or other compatible software to edit when working on a Qlik server maschine.

I found [Advanced CSV](https://github.com/wadetb/Sublime-Text-Advanced-CSV) to be quite useful for handling my csv-files. I motstly use it for the ability to justify columns, but it also offer the possibility to select/add/remove columns which is hard todo in an text editor without this extension.

### 5.  Sidebar enhancements
An other useful plugin is the [Sidebar Enhancements](https://github.com/SideBarEnhancements-org/SideBarEnhancements). It enhances your  sidebar with easy access to often used tasks such as _move, copy, rename, run, refresh etc._

You can use package control to install the Sidebar enhancement plugin. Follow the steps you used when installing InQlik Tools in the section above.

### 6. Comment script shortcut
The default sublime comment shortcut is `Ctrl-/`{: .btn} and `Ctrl-Shift-/`{: .btn}. In QlikView and Qlik Sense I am used to `Ctrl-K`{: .btn} combinations for commenting and un-commenting script. <del>Therefore I use to change the default key bindings in Sublime into Qlik Sense syntax, `Ctrl-K` and `Ctrl-Shift-K`.</del> `Ctrl-K`{: .btn} is used as a base for multiple shortcuts in Sublime, because of that I've started to define my shortcut as `Alt-K`{: .btn}	and `Alt-Shift-K`{: .btn}.  You will find the setup for key bindings in the preferences pane. See picture below.   

![Sublime Key Bindings]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01/Sublime_key_bindings.png)

To change my key binding I  type the following into my key binding user config file.
```
[
 { "keys": ["alt+k"], "command": "toggle_comment", "args": { "block": false } },
 { "keys": ["alt+shift+k"], "command": "toggle_comment", "args": { "block": true } },
]
```

### 7. Dark text on light background
I prefer dark text on light canvas when working in daylight. The built in LAZY, Eiffel and iPlastic are good alternatives to the black default theme. Give them a try, you will find then under the Preferences menu.

![Comparison of light themes i Sublime Text 3]({{ site.url }}{{ site.baseurl }}/assets/images/2017/01/sublime_light_theme.png)

### 8. Markdown
If you are used to write documentation using markdown syntax, then the [Markdown Preview](https://github.com/revolunet/sublimetext-markdown-preview) and [MarkdownEditing](https://github.com/SublimeText-Markdown/MarkdownEditing) are good final tweaks to your Sublime. It also possible to use these plugin to prettify your QVD meta data output hence that is written with markdown syntax. It is available through Package control.

### 9. Show encoding
If you use special characters, like ä, ü, é and æ,  in your qvs scripts then the file encoding becomes an issue. I usally do this little tweak in my preferences file. It adds a little indication in the bottom right corner of which encoding my open file is using.

_Preferences_ --> _Settings_
```
{
  "show_encoding": true
}
```

### Final words
This setup works for me for traditional QlikView and Qlik Sense scripting. I have not included any tweaks or adjustments to meet demands for developing against the the [Qlik API capabilities](https://help.qlik.com/en-US/sense-developer/3.1/Content/APIs-and-SDKs.htm). If you are working with a sublime setup for this please share. Write your own blogpost or type something shorter in the comment section below.  You are also welcome to comment if you have comments, other tips tweaks or plugins that helps in your Qlik Sense or QlikView development.