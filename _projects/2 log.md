---
name: Log
image: /assets/img/2022/Brown_Chop_Logs_on_Outdoor.jpg
permalink: /project/log
---

# <a class="qicon-data-load"/> Log

Log is a reusable qlik script that can log script activities on multiple levels.

#### Example of a call

```qve
call log_start('Load databases')
  //Script that loads databases
call log_end
call log('The seconde and final log entry')
```

### Log.qvs

```qve
{% include sublib/data_load_script/sublib.log.qvs %}
```


You can download a Qlik Sense application that demonstrates this sub from Github [veglar/qliksense-sublib/releases](httpshttps://github.com/veglar/qliksense-sublib/releases)

If you find errors or see opportunities for improvement in the code, please file an issue here: [https://github.com/veglar/qliksense-sublib/issues](https://github.com/veglar/qliksense-sublib/issues)