---
id: 278
title: Best practices for keeping your Qlik framework under version control
date: 2016-04-12T11:14:43+01:00
guid: http://aqlik.se/?p=278
permalink: /2016/04/best-practices-for-keeping-your-qlik-framework-under-version-control/
image: /wp-content/uploads/2014/11/containers-672x352.png

---
I've worked with multiple Qlik environments where  Qlik Deployment Framework (QDF) is combined with a version control system during the past years. This hands on experience from multiple environments combined with several interesting discussions with colleagues, clients and Qlik have given me an insight on dos and do nots. The following post is a part of my best practice when working with version control in a QlikView environment.<!--more-->

## Create a repository per container
A container is its own universe, you can copy it, replicate it or move it and it will still work without modifications. It is a good idea to create a repo per container.

In GIT you are limited to check in/out whole repositories, you are not able to select designated parts of if. If you choose to have a single repository for the whole environment you will be forced to check out your whole qlik environment everytime you check out a project. I always recommend to split an environment into multiple repositories, one per container.

Using Subversion you are not enforced to the full repository, it is pretty easy limit which part of the repository you want to check out. You may still consider the one-repository-per-container approach using Subversion. One scenario is where different developers are responsible for and should have access to different applications.  By configuring repository access according to the developer rights you may prevent unauthorized/accidential  commits by unauthorized developers.

![Containerscrop]({{ site.url }}{{ site.baseurl }}/assets/images/2014/11/Containerscrop.png)
The QDF opens up for the architect or administrator to rearrange container structures without breaking script functionality. There could be several reasons for moving a container, but often it is related to business changes. The location/arrangement of containers does not change any Qlik functionally and should neither affect the repository, is a one-repo-per-container setup separation is maintained, but in a single repository environment a change in container structures will generate a lot of changes in the version control system.

## Exclude your qvw and data files
Always exclude your binaries and data files. I see the version control as as system for tracking changes in your source code, it is not a back-up system.

The QlikView file (qvw) contains both the layout, script and data. It is stored binary and it is impossible for a version control system to determine which changes that have been done, it will basically commit your whole application into the repository database on every commit.  A large sized application will rapidly increase the size of your version tracking database, hence every time it runs the binary qvw file will be diffrent from the previous execution.
  
>Always put all qvw and qvd files into the ignore list of the version control system.

It is sufficient  to track the prj folder instead of the qvw. The prj folder contains all the layout and data modeling information of the QlikView file. The files of the prj-folder is stored as readable xml files. With the solely the prj folder it is possible to build a new replica of the qvw file it represents empty for data transactions.

Data you load into applications will most likely change over time , data files should therfore never be committed into the version control system. This principle is valid both for data files you import into (excel, csv, etc.) and data files created by your application (qvd).

## Keep the frame of the framework outside the version control.

<img class="wp-image-296 size-medium" src="{{ site.url }}{{ site.baseurl }}/assets/images/2016/04/scaffolding-1463583-639x803.jpg" alt="Scaffolding"/> _FreeImages.com/Bo de Visser_

&nbsp;

I consider the framework files not to be a part of my developed source code. I see the framework files as the frame in where I put my developed source code. The frame is not in the developers responsibilities and she should not be make any changes into it. If changes are to be made they should be global for all containers, therefore I consider it the Qlik architect or administrator's responsibilty. If every developer where allowed to make small adjustments and tweaks to the framework files and then the organization desides to upgrade the framework to and later release and thereby overwrite the framework files tweaks.

By excluding the default qdf container files from version control it becomes very clear to the developer what is the project specific source code files and what is not.

&nbsp;
## Track your development, but stage for the rest
Only the development envrionment should be connected to the version control system. When  the development process is finished the developer should stage her changed files so that they may be copied throughout the DTAP street.
<blockquote>Keep the development in the development environment by cutting all ties to the version control system in test, acceptance and production environment</blockquote>
There is a QlikView server specific reason why you should avoid connecting  the test, acceptance and production environment to fetch from your version control system. I have earlier argued why qvw files should be kept out of the version control.  The QlikView desktop client will first consider the prj-folder information when opening a QlikView qvw-file. The server on the other hand will not consider the prj folder at all, it will only what is prestored into the qvw file. If all changes are pushed out to the prj-folder's xml-files in the DTAP street the server will not recognize any changes until you have manually opened and saved the qvw file with the desktop client. To avoid this repetative task in all your environments you should always prepare your qvw files in the development and push them through the DTAP street.

There is also the principle that all changes should reside in the development environment, no changes should be committed after are put into any of the other envrionments. Cutting ties to the version control in test, acceptance and production will help prevent occational developing beeing done in these enviroments.
## Limitation
There are limitations in version handling solely the prj-folder files of an application in QlikView. <em>Always one selected value</em> is one example where this property is lost when the qlikview file is stripped for data, certain action triggers are another feature that Qlik handles porly when it comes to version control. In cased where these are important features I make sure to stage my qvw from the same location and qvw-file every time, and I make sure the staged qvw-file is not empty.

I have been using these principles in QlikView Qlik Sense coexistence environments, where script mainly resides in external Qlik Script Files, but it does not cover how to track and handles Qlik Sense applications? If you have any inputs please share them in the comments field below or on your own blog.
## Additional reads.
[Qlik IDE Development environment](https://community.qlik.com/docs/DOC-8157) - Qlik's take on how to hand on combine QDF and version control ( Tortoise SVN)  using Sublime text editor.    
[Using Git with Qlikview to version control your projects](https://biexperience.wordpress.com/2013/10/30/using-git-with-qlikview-to-version-control-your-projects/)
