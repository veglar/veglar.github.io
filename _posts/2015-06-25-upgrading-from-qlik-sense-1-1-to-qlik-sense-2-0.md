---
id: 270
title: Upgrading from Qlik Sense 1.1 to Qlik Sense 2.0
date: 2015-06-25T20:50:27+01:00
guid: http://aqlik.se/?p=270
permalink: /2015/06/upgrading-from-qlik-sense-1-1-to-qlik-sense-2-0/
---
Qlik Sense 2.0 is  finally available.  A lot of installs and upgrades will be done in the coming weeks. Here is a guide on how I do my single node upgrades.

## Backups
Stop all Qlik services except the Qlik Sense Repository before starting your backup. Turn them back on again when the backup is done.

I want to have the following backups before installing anything new.

- Repository
- Certificate
- Logs
- Qlik Sense Application files
- Qlik Sense Repository files
- The QDF file structure

<h3>Certificate</h3>
You should always have a backup of the certificates. Without it you're smoked.

- SSL certificat
- Client certificate
- Certificate Authority (CA)

Details on how to do it I find on the Sense Help site: <a href="http://help.qlik.com/sense/2.0/en-US/online/#../Subsystems/PlanningQlikSenseDeployments/Content/Server/Server-Backup-Recovery-Certs-Export-Certs.htm" target="_blank">Backing up certificates</a>
<h3>Postgree database</h3>

`cd "C:\Program Files\Qlik\Sense\Repository\PostgreSQL\<database version>\bin"`    
`pg_dump.exe -h localhost -p 4432 -U postgres -b -F t -f "c:\QSR_backup.tar" QSR`

<h3>Log files</h3>
The Qlik Sense log files are located at  `%ProgramData%\Qlik\Sense\Log`

<h3>Qlik Sense applications</h3>

`%ProgramData%\Qlik\Sense\Apps\` (Which is  _C:\ProgramData\Qlik\Sense\Apps_ on a  Windows Server 2008)

<h3>Qlik Sense repository - content and extensions</h3>

`%ProgramData%\Qlik\Sense\Repository\Content`
`%ProgramData%\Qlik\Sense\Repository\Extensions`

<h3>The QDF root</h3>
I prefer to use the QDF structure both in QlikView and Sense. Backup the whole root catalog. If you are not using it then just backup the folder/folders containing files used by your qlik sense scripts etc. Eg. standarized scripts, variable files and QlikView components.

<h2>Install Sense 2.0</h2>
Installation is the easy part of upgrading. Download the installation file from Qliks download site. Run the setup file. Click throug the welcome and license dialogs.

Choose "Quick upgrade".  You'll be prompted for Postgree SQL password and the password for the account running the services.  Make sure you have them in hand.

![Upgrade complete](http://aqlik.se/wp-content/uploads/2015/06/Upgrade-complete.png)

Hopefully you'll see the same upgrade summary as in the picture above and you're ready to go.