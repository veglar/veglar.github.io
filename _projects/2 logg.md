---
name: Logg
image: /assets/img/2022/Brown_Chop_Logs_on_Outdoor.jpg
permalink: /projekt/logg
---

# <a class="qicon-data-load"/> Logg

Logg  är ett återanvändbart qlikskript som kan logga skriptaktiviteter i flera nivåer. 

#### Exempler på anrop

```qve 
call sublib.logg.start('Ladda databaser')
  //Skript som laddar databaser
call sublib.logg.stop      
```

### Logg.qvs

```qve
{% include sublib/data_load_script/sublib.logg.qvs %}
```