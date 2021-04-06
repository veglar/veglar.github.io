---
id: 203
title: QlikView Server Super Agent
date: 2014-11-24T12:55:31+01:00
author: Vegar Lie Arntsen
guid: http://aqlik.se/?p=203
permalink: /2014/11/qlikview-server-super-agent/
---
<strong>My latest Qlik re-discovery is the QlikView Server Super Agent, a power tool that monitor and log  QlikView services. It do also alert me or the IT administration by email  if one of the a services goes down.</strong>

## Power tools

The QlikView Server Super Agent is one of the many small smart tools that are bundled into the <a href="http://community.qlik.com/docs/DOC-5903">QlikView Power Tools</a>. The Power tool package is created by people at <a title="QlikTech International AB" href="http://www.qlik.com">Qlik</a> and may be used free of charge,  but it is not an official Qlik product and therby not supported by Qlik.

As far as I understand does the Power Tools only support QlikView 10, 11 and 11.20. Qlik Sense is not supported at the moment. 

## Setup

There application is simpel to set up. In the left pane you have a root node and to that node you add groups that you attach services to.

![QlikViewServerSuperAgent]({{ site.url }}{{ site.baseurl }}/assets/images/2014/11/QlikViewServerSuperAgent.png)

I see three main directions for structuring these groups and which one you choose all depends on the complexity level of your QlikView environment.

#### 1. By machine

Create one group per machine and add the services in question.

#### 2. By environment

When handling multiple environments  (test, acceptance test and production)  I suggest to create a nodes for each environment.

#### 3 By environment and product

In non clustered environments where you have only one machine per product you do not gain much by expanding the structure with a prioduct dimension. In (larger) clustered environments I would considered creating groups based on environment and product such as "Test - Servers" and "Production - Publishers".

## Adding email notification

<a href="{{ site.url }}{{ site.baseurl }}/assets/images/2014/11/QlikViewServerSuperAgentSettings.png"><img class="alignnone wp-image-232 size-full" src="{{ site.url }}{{ site.baseurl }}/assets/images/2014/11/QlikViewServerSuperAgentSettings.png" alt="QlikViewServerSuperAgentSettings" width="730" height="360" /></a>

Entering the settings menu it is also possible to setup e-mail notification and adjust monitoring frequency and other settings such as log path and frequency.

## When and how to use is

I use this tool locally when installing new  or upgrading old QlikView  environments. It gives me an status overview for all QlikView services. It does also work as a short-cut for launching another power tool *QlikView Server Agent* that allow me to start and stop services efficiently.

The notification feature is important  for an system administrator or someone who are to monitor the QlikView environment. For monitoring you will have to make sure that the application is running constantly. Normally you need to be logged in to a machine to run a application, but triggering the application from Windows Task Scheduler is an alternative. If you do that then make sure you set up the tool correctly for that user, you do not share  setting between user per default. To get rid of the logged-in or task manager requirement I would love to see the QlikView Server Super Agent as a service in the future.