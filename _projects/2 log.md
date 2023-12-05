---
name: Logg
image: /assets/img/2022/Brown_Chop_Logs_on_Outdoor.jpg
permalink: /projekt/log
---

# <a class="qicon-data-load"/> Log

Logg  är ett återanvändbart qlikskript som kan logga skriptaktiviteter i flera nivåer. 

#### Exempler på anrop

```qve 
call sublib.log.start('Ladda databaser')
  //Skript som laddar databaser
call sublib.log.stop      
```

### Logg.qvs

```qve
{% include sublib/data_load_script/sublib.log.qvs %}
```


Du kan hämta hem en Qlik Sense applikation som demonstrerar denna sub från Github [veglar/qliksense-sublib/releases](https://github.com/veglar/qliksense-sublib/releases)

Hittar du fel eller ser förbättringsmöjligheter i koden så lägg gärna ett ärende här: [https://github.com/veglar/qliksense-sublib/issues](https://github.com/veglar/qliksense-sublib/issues)
