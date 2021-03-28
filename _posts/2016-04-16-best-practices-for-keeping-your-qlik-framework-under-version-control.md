---
title: "Best practices for keeping your Qlik framework under version control"
last_modified_at: 2021-03-26
toc: true
toc_label: eaders
toc_sticky: TOC
toc_icon: heading

---

This my best practices for keeping my QlikView development under version control when using Qlik Deployment Framework, QDF.

# Choose a version control software
I always ask which a version control system, if any, a client are using before I start on a QlikView development assignment, I often get "none" as an answer, in these cases I recommend the client to add one and a GUI tool to the development machine I'll be working on. If the client ask for a recommendation I normally list the following three softwares. 
- **GIT** - a version control system from from [git-scm.com/downloads](https://git-scm.com/downloads))
- **Git Extensions** - a GUI-client to manage GIT repositories from [gitextensions.github.io](https://gitextensions.github.io/))
- **kDiff3** - a graphical text difference analyzer  [download.kde.org/stable/kdiff3](https://download.kde.org/stable/kdiff3/)

With that trio of free software installed on my development environment I have all that I need to start version controlling my QlikView development. 

# Set the scope of the repositories
What should the scope of your repository/repositories be? 

I've worked in environments where everything is contained in one repository and in environments where every application got its own repository. Both scopes works, but when creating a repo per application you might miss the oppurtunity to track the changes to important supporting files such as external script files and variable files. I often use supporting files in my work hence I tend to have a wider scope in my repos. 

When working in the Qlik deployment framework we often run into a similar scoping questions when deciding how to set up the QDF container structure. Which QlikView documents should be coupled into the same containers? I have found the best strategy for scoping my GIT repositorys is to free-ride on the design decitions when setting up the QDF; creating **one repository per QDF container**. 

Coupling QDF Containers with GIT repositories have other benefits as well, it complies very well to the concept of beeing able to change locations on a container. In the QDF you are able to re-locate the QDF Containers without the any changes in the source code of the QlikView documents.  

If you decide to change the physical location of a container it will not affect a container level GIT repository, but if you have one repoistory for the whole QDF structure then the source code would be considered changed if you move the container location. 


---
ContainerscropThe QDF opens up for the architect or administrator to rearrange container structures without breaking script functionality. There could be several reasons for moving a container, but often it is related to business changes. The location/arrangement of containers does not change any Qlik functionally and should neither affect the repository, is a one-repo-per-container setup separation is maintained, but in a single repository environment a change in container structures will generate a lot of changes in the version control system.

Exclude your qvw and data files
Always exclude your binaries and data files. I see the version control as as system for tracking changes in your source code, it is not a back-up system.

The QlikView file (qvw) contains both the layout, script and data. It is stored binary and it is impossible for a version control system to determine which changes that have been done, it will basically commit your whole application into the repository database on every commit.  A large sized application will rapidly increase the size of your version tracking database, hence every time it runs the binary qvw file will be diffrent from the previous execution.

Always put all qvw and qvd files into the ignore list of the version control system.

It is sufficient  to track the prj folder instead of the qvw. The prj folder contains all the layout and data modeling information of the QlikView file. The files of the prj-folder is stored as readable xml files. With the solely the prj folder it is possible to build a new replica of the qvw file it represents empty for data transactions.

Data you load into applications will most likely change over time , data files should therfore never be committed into the version control system. This principle is valid both for data files you import into (excel, csv, etc.) and data files created by your application (qvd).

Keep the frame of the framework outside the version control.
Scaffolding
FreeImages.com/Bo de Visser
 

I consider the framework files not to be a part of my developed source code. I see the framework files as the frame in where I put my developed source code. The frame is not in the developers responsibilities and she should not be make any changes into it. If changes are to be made they should be global for all containers, therefore I consider it the Qlik architect or administrator’s responsibilty. If every developer where allowed to make small adjustments and tweaks to the framework files and then the organization desides to upgrade the framework to and later release and thereby overwrite the framework files tweaks.

By excluding the default qdf container files from version control it becomes very clear to the developer what is the project specific source code files and what is not.

 

Track your development, but stage for the rest
Only the development envrionment should be connected to the version control system. When  the development process is finished the developer should stage her changed files so that they may be copied throughout the DTAP street.

Keep the development in the development environment by cutting all ties to the version control system in test, acceptance and production environment

There is a QlikView server specific reason why you should avoid connecting  the test, acceptance and production environment to fetch from your version control system. I have earlier argued why qvw files should be kept out of the version control.  The QlikView desktop client will first consider the prj-folder information when opening a QlikView qvw-file. The server on the other hand will not consider the prj folder at all, it will only what is prestored into the qvw file. If all changes are pushed out to the prj-folder’s xml-files in the DTAP street the server will not recognize any changes until you have manually opened and saved the qvw file with the desktop client. To avoid this repetative task in all your environments you should always prepare your qvw files in the development and push them through the DTAP street.

There is also the principle that all changes should reside in the development environment, no changes should be committed after are put into any of the other envrionments. Cutting ties to the version control in test, acceptance and production will help prevent occational developing beeing done in these enviroments.

Limitation
There are limitations in version handling solely the prj-folder files of an application in QlikView. Always one selected value is one example where this property is lost when the qlikview file is stripped for data, certain action triggers are another feature that Qlik handles porly when it comes to version control. In cased where these are important features I make sure to stage my qvw from the same location and qvw-file every time, and I make sure the staged qvw-file is not empty.

I have been using these principles in QlikView Qlik Sense coexistence environments, where script mainly resides in external Qlik Script Files, but it does not cover how to track and handles Qlik Sense applications? If you have any inputs please share them in the comments field below or on your own blog.

Additional reads.
Qlik IDE Development environment – Qlik’s take on how to hand on combine QDF and version control ( Tortoise SVN)  using Sublime text editor.

Using Git with Qlikview to version control your projects – Hands on getting started blogpost from BI Experience

