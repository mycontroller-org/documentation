---
title: "Schedules"
linkTitle: "Schedules"
weight: 3
---
Holds a collection of schedules.
Schedules are executed by a scheduler service.<br>
Schedule can bse used for different use cases.<br>
The most famous one is turn ON a light at specific time and turn OFF a light at a specific time.<br>
But in MyController it is not limited to lights. You can control variety of resources.<br>

Schedule has a different sections. All the sections are explained here.<br>

{{< alert title="Important" color="warning">}}
Schedules will be executed based on the system timezone.<br>
If you change the system timezone, it is mandatory to restart the MyController service.<br>
{{< /alert >}}

## Identity
##### Form View
![id and description](/doc-images/schedule_add_id.png)

##### YAML View
```yaml
id: my_first_schedule # (1)
description: This is my first schedule # (2)
enabled: true # (3)
```
1. `id` - should be a unique identifier
2. `description` - add description about this schedule
3. `enabled` - enable/disable this schedule

## Labels
You can add any number of labels. Labels can be used to filter a group of schedule.<br>
Labels can be used to perform an action on a group schedules.<br>

##### Form View
![labels](/doc-images/schedule_add_labels.png)

##### YAML View
```yaml
labels:
  group: essential
```

## Validity
Validity is a special feature. You can control when this schedule should be effective.<br>
All the fields are optional. By omitting a field gives different meanings<br>

*To get activate this feature validity should be enabled*<br>

### Date and Time
Based on the given fields, validity reacts as follows,

* If non of the fields entered - valid for all the time.

* `date.from` - schedule will be valid from the given `from date`.<br>
  There is no `from time` entered here, but `from date` is available. Hence `from.time` will be calculated as `00:00:00`<br>
  *Example:* `2021-09-16` becomes `2021-09-16 00:00:00`<br>

* `date.to` - schedule will be valid till the given `to date`.<br>
  There is no `to time` entered here, but `to date` is available. Hence `to.time` will be calculated as `23:59:59`<br>
  *Example:* `2021-09-24` becomes `2021-09-24 23:59:59`<br>

* `date.from`, `time.from` - schedule will be valid from the given `from date` and `from time`.

* `date.to`, `time.to` - schedule  will be valid till the given `to date` and `to time`.

* `date.from`, `date.to`, `time.from`, `time.to` - schedule can be valid between the `from date/time` ~ `to date/time`.

* `validateTimeEveryday` => `Disabled` - valid exactly `from date/time` ~ `to date/time`.<br>
  *Example:* `2021-09-16 11:15:00` to `2021-09-24 19:00:00`

* `validateTimeEveryday` => `Enabled` - between these date and the time valid for every day.<br>
  *Example:* between`2021-09-16` to `2021-09-24` - time is valid for every day between `11:15:00` to `19:00:00`

##### Form View
![validity](/doc-images/schedule_add_validity.png)

##### YAML View
```yaml
validity:
  enabled: true
  date:
    from: '2021-05-14'
    to: '2021-06-21'
  time:
    from: '00:00'
    to: '23:59'
  validateTimeEveryday: false
```

## Schedule Type
Schedule supports different types.

  * [Repeat](#repeat)
  * [Cron](#cron)
  * [Simple](#simple)
  * [Sunrise](#sunrise)
  * [Sunset](#sunset)

### Repeat
Repeat is a super simple schedule.<br>
* Executes the schedule on the specified `interval` till it reaches the `repeat count`.
* Set `repeat count` to `0` to keep on repeating.

{{< alert title="Note">}}
Very first execution starts after the given `interval`.
{{< /alert >}}

### Cron
Cron is a time-based job scheduler in Unix-like computer operating systems.<br>
In MyController in addition to that, it supports `seconds` field.<br>
Refer [Cron wikipedia page](https://en.wikipedia.org/wiki/Cron) to know more about cron.

```
┌───────────── second (0 - 59)
| ┌───────────── minute (0 - 59)
│ | ┌───────────── hour (0 - 23)
│ | │ ┌───────────── day of the month (1 - 31)
│ | │ │ ┌───────────── month (1 - 12)
│ | │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday;7 is also Sunday on some systems)
│ | │ │ │ │                                   
│ | │ │ │ │
│ | │ │ │ │
* * * * * *
```
The first field `second` is optional, you can omit it.<br>
Also supports `@yearly`, `@monthly`, `@weekly`, `@daily (or @midnight)`, `@hourly`

### Simple
Simple is a friendly schedule type.<br>
It supports different type of frequencies.<br>
 * [Daily](#frequency---daily)
 * [Weekly](#frequency---weekly)
 * [Monthly](#frequency---monthly)
 * [On Date](#frequency---on-date)

Schedule executes on the specified time, if the day meets the specified frequency.<br>
`Time` can be specified in the format of `hh:mm:ss`. hours should be in 24 hours format<br>
*Examples:<br>*
  * `05:00:00` - 5 AM
  * `12:30:20` - 12:30:20 PM
  * `17:15:00` - 5:15 PM

#### Frequency - Daily
In this mode you can restrict the schedule to the selected week days.
* Possible select multiple days of a week.
* Schedule executes on the selected days of the week.

#### Frequency - Weekly
In this mode you can restrict the schedule to particular week day.
* Select a day in week.
* Schedule executes on the selected day of the week.
* In simple words, only once in a week.

#### Frequency - Monthly
In this mode you can restrict the schedule to particular day of month.
* Select a date in a month
* Schedule executes on the selected date of the month
* In simple words, only once in a month

{{< alert title="Note">}}
If you select non-common date, ie: `29`, `30`, and `31`<br>
The schedule execution will be skipped for a month, if it does not have the date mentioned above.
{{< /alert >}}

#### Frequency - On Date
In this mode you can restrict the schedule to particular date and time.
* This schedule executes only once in a life time.

### Sunrise
Sunrise works similar to [Simple schedule](#simple), expect the time part.<br>
Here explained only about the time part. refer [Simple schedule](#simple) for other options.<br>

Based on the [GEO Location](/docs/user-interface/settings/system/#geo-location) configured for the system,
Sunrise time will be calculated. This calculation happens every day at midnight of the system timezone.<br>

##### Offset
Offset used to calculate the exact time to execute the schedule.<br>
Offset is a time duration. Refer [duration guide](/docs/getting-started/hints/#duration-of-the-time) for the detailed information.<br>

*Examples:*
  * `10m` - executes 10 minutes after the sunrise time
  * `-10m` - executes 10 minutes before the sunrise time
  * `1h20m` - executes 1 hour and 20 minutes after the sunrise time
  * `-1h20m` - executes 1 hour and 20 minutes before the sunrise time

### Sunset
Sunset works similar to [Simple schedule](#simple), expect the time part.<br>
Here explained only about the time part. refer [Simple schedule](#simple) for other options.<br>

Based on the [GEO Location](/docs/user-interface/settings/system/#geo-location) configured for the system,
Sunset time will be calculated. This calculation happens every day at midnight of the system timezone.<br>

##### Offset
Offset used to calculate the exact time to execute the schedule.<br>
Offset is a time duration. Refer [duration guide](/docs/getting-started/hints/#duration-of-the-time) for the detailed information.<br>

*Examples:*
  * `10m` - executes 10 minutes after the sunset time
  * `-10m` - executes 10 minutes before the sunset time
  * `1h20m` - executes 1 hour and 20 minutes after the sunset time
  * `-1h20m` - executes 1 hour and 20 minutes before the sunset time

## Load variables
Load variables is an optional configuration.<br>
Follow [Load Variables Guide](/docs/user-interface/operations/load_variables/) for the detailed configuration.

Use variables when you want to, 
  * play with [Javascript](/docs/user-interface/operations/javascript/)
  * `enable` or `disable` [Parameters to handler](/docs/user-interface/operations/parameters_to_handler/)

## Load Custom Variables
Sometimes you may want to do some calculations or based on a value you want to set something,
In those cases `Load Custom Variables` will be used.

### Types
  * None
  * Javascript
  * Webhook

#### None
Whe you do not want to use `Load Custom Variables` feature, use `None` option.

#### Javascript
Follow [Javascript Guide](/docs/user-interface/operations/javascript/) for the details.

#### Webhook
Follow [Webhook Guide](/docs/user-interface/operations/webhook/) for the details.

## Parameters to Handler
Follow [Parameters to Handlers Guide](/docs/user-interface/operations/parameters_to_handler/) for the detailed configuration.

## Notify Handlers
Follow [Notify Handlers Guide](/docs/user-interface/operations/notify_handlers/) for the detailed configuration.