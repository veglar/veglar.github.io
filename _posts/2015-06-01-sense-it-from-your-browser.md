---
id: 252
title: Sense it from your browser
date: 2015-06-01T22:30:26+01:00
author: Vegar Lie Arntsen
guid: http://aqlik.se/?p=252
permalink: /2015/06/sense-it-from-your-browser/
image: /wp-content/uploads/2015/06/premierleague.wikipedia.senseit.result.featurepng-672x227.png

---
A couple of months ago I discovered a neat <a href="https://chrome.google.com/webstore/detail/senseit/haifjhcobciacleiahcdnndlgankbdoa?utm_source=aqlik.se">Chrome Plugin for Qlik Sense</a>. It allow me to drag and drop table data from my browser into a Qlik Sense application.  I haven't used it a lot, but it is quite handy when you run upon a small dataset on internet that you want to capture into Sense. It is also quite sweet to use when demoing Qlik Sense.
<h3>Fetching the final premier league table into Sense.</h3>
![premierleague.wikipedia]({{ site.url }}{{ site.baseurl }}/assets/images/2015/06/premierleague.wikipedia.png) I found the final Premier League standings on the <a href="http://en.wikipedia.org/wiki/2014–15_Premier_League">2014-15 Premier League</a> page on wikipedia. I want to pull this data into a Qlik Sense application.

![premierleague.wikipedia.senseit]({{ site.url }}{{ site.baseurl }}/assets/images/2015/06/premierleague.wikipedia.senseit.png)

If you've installed the SenseIt extension you'll notice a Qlik green barcart icon in top of your browser. When visiting the webpage holding data, click the SenseIt icon and you'll a pop-up window where you should drag and drop your table.

![premierleague.wikipedia.senseit.import]( {{ site.url }}{{ site.baseurl }}/assets/images/2015/06/premierleague.wikipedia.senseit.import.png) 

The table will be preview in the extension window where you will be able to do configuration of the import by specifying column headers, decimal separator, thousand separator and whether you should transpose the table in question or not.

<ul>
	<li>Click the "Create App" button.</li>
	<li>Click the "Open App" button.</li>
</ul>
Viola! Your Qlik Sense application is created and loaded with your data and you are ready to start designing your application.

![premierleague.wikipedia.senseit.result]( {{ site.url }}{{ site.baseurl }}/assets/images/2015/06/premierleague.wikipedia.senseit.result.png)


SenseIt is created for the Chrome browser, but I managed to install it on Opera as well without any problems using the [Download Chrome Extension](https://addons.opera.com/sv/extensions/details/download-chrome-extension-9) for Opera. SenseIt is also available as an <a href="http://branch.qlik.com/projects/showthread.php?364-SenseIt-Chrome-Extension">open source project on Qlik Branch</a>.
