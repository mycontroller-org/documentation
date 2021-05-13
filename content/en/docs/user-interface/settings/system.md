---
title: "System"
linkTitle: "system"
weight: 2
---
The system settings has the following configurations
  * [GEO Location](#geo-location)
  * [Login Page](#login-page-message)


## GEO Location
GEO Location address the current location of the server or ask to follow the given location as server location and operate dependent services.<br>
This detail used to calculate `Sunrise` and `Sunset` times in [Schedule](/docs/user-interface/operations/schedules/)

##### Form View
![geo location](/doc-images/settings_system_geo_location.png)

* `Auto Update` - Enabling this field can take the server location based on the WAN IP address.<br>
  If you want to give the value manually, disable this field.
* `Location Name` - Name of the location
* `Latitude` of the location
* `Longitude` of the location

##### YAML View
```yaml
geoLocation:
  autoUpdate: false
  locationName: Namakkal
  latitude: 11.2189165
  longitude: 78.1586027
```

## Login Page Message
You can enter a message to display on the login page of the console.<br>
The message supports HTML tags.

##### Form View
![login page message](/doc-images/settings_system_login_page.png)

##### YAML View
```yaml
login:
  message: |-
    This is a private MyController instance. Running in a local Raspberry PI
    <br>Default username and password: admin / admin
```