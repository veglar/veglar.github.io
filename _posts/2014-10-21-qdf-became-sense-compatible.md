---
id: 62
title: QDF became Qlik Sense compatible
date: 2014-10-21T05:04:22+01:00
guid: http://aqlik.se/?p=62
permalink: /2014/10/qdf-became-sense-compatible/
image: /wp-content/uploads/2014/10/1.4.1.QDF_-672x369.png

---
From the first time I heard about Qlik Sense (.next) the Qlik architecture team stated that QlikView users would benefit from using the QlikView Deployment Framework (qdf). This became obvious last Thursday when Qlik released version 1.4.1 of the framework with support for both Qlik Sense Desktop and Qlik Sense Server.

With this latest release you can use the same framework and scripts in both QlikView and Sense environment. When using the framework all sub libraries used in QlikView will be available in Sense without modifications. All QDF global and universal variables will also transfer seamlessly into sense.

If your current current QlikView environment is build on qfd then this upgrade will enable a really fast migration to a Sense environment. All scrip will run without modification in both environments.

Note that you still have to handle the graphical user interface manually. There is still not an automated method of transferring reports in QlikView Qlik Sense. I don't think it Qlik will ever provide that.

<h2>Initiate qdf in Sense</h2>

In QlikView it is possible to initiate the QDF by absolute or relative path.

<pre><code>$(Include=../../3.Include\1.BaseVariable\1.Init.qvs);    
</code></pre>

As default Sense does not understand absolute nor relative paths. (Sense in Legacy mode does). A library is needed to trigger the QDF a in native mode. There are two ways to implement QDF Libraries.

<h3>QDF root mount</h3>

The first method is the easiest. Mount the QDF root (the folder containing 0.Administration) as a library called <em>Root</em>. It will map up the whole qdf structure in one mount. If a developer gets access to the Root Library then the developer will have access to the whole QDF structure. The only situation where I would not use this is when I want to segment back end access.

<img src="{{ site.url }}{{ site.baseurl }}/assets/images/2014/10/LibRoot.png" alt="Root qdf library" />

As seen in the picture above. The Root contains all of the QDF Structure. I is a convenient method for getting the QlikView qdf up and running in Sense

<strong>Variable references</strong>
With a single root mount vG.QVDPath for the Transform container will be:
<code>LIB://Root\2.Transform\2.QVD\</code>

<h3>Separate containers mount</h3>

If you are managing a Qlik Sense environment that is to have segmented access for source files you should consider mounting separate mounts for each container. Whith this method you can manage which developer is to see which container. Maybe you want to limit the access to the administration or extract containers or only give a developer access to the container she is to develop in, then separate mounts is the way to go.

<img src="{{ site.url }}{{ site.baseurl }}/assets/images/2014/10/SingleContainerRoot.png" alt="enter image description here" />

QDF inteprets the Lib name as it is the variable prefix defined in the Container Map. Creating a lib named Admin would be the correct naming for creating a separate mount for the 0.Administration container in the default installation. The big benefit by using separate mounts is that I can put different access rights to different parts of my environment.

<strong>Variable references</strong>
With separate mounts vG.QVDPath for the Transform container will be:
<code>LIB://Transform\2.QVD\</code>

<h2>Combining Root and Separate mounts</h2>

There is also possible to use a mix of the two mounts types in Sense. If two containers with the same prefix is mounted in the same environment then QDF will prioritie the one found in the separate container mount.

I as a developer it is possible for me to mount a new version of a container into the framework without any changes to the original root QDF file structure. Imagine a scenario from the picture below where I have prepared an new version of Transform that I need to test in the QDF.

<img src="{{ site.url }}{{ site.baseurl }}/assets/images/2014/10/QdfContainerStructure.png" alt="QDF container folder structure" />

The <code>2.1.Transform</code> is a good candidate for replacing <code>2.Transform</code>. I need to test the output of my new candidate in the final application, but I do not want to make any code changes to my other containers. I have a mounted Root with the container structure presented in the Deployment Framework Container Map Editor below.

<img src="{{ site.url }}{{ site.baseurl }}/assets/images/2014/10/1.4.1.QDF_.png" alt="Deployment Framework Container Map Editor 1.4.1" />

By mounting my 2.1.Transform as a Lib named Transform will make Sense QDF prioritize this single mount named over the Transform in the Root. My application that originally read data from <code>2.Transform</code>it will now read from <code>2.1.Transform</code> afterwards.

This is a powerful way of mixing in new data into the QDF without making changes to the folder structure, it is good for testing. By going into the think box this feature could have many more practical applications where data and/or security could be in focus. Please share if you have put this mixed feature to good use.

<h2>Getting Started with QDF for Sense</h2>

The place to start when it talking Qlikview Deployment Framework is the Qlik Community Group: [qlikview-deployment-framework](http://community.qlik.com/groups/qlikview-deployment-framework). Strongly recomended.

<blockquote>"<em>The path for migrating to Sense lies in the Qlikview Deployment Framework</em>"</blockquote>