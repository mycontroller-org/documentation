---
title: "Toolbar"
linkTitle: "Toolbar"
weight: -1
---
Toolbar component contains various elements like [filters](#filters), [Action Buttons](#action-buttons), [Quick Buttons](#quick-buttons).<br>
Toolbar will be placed on top of all the list resources page.<br>
![toolbar](/doc-images/mc_toolbar.png)


## Filters
![filter1](/doc-images/mc_filter1.png)
* By clicking the `Filters` button you can see the list of available filter options
* Each filter is a field on the resource
* Selecting more than one filter applies `AND` logic
* By selecting a filter you can see one of the following filter
  - Text input filter
  - Selection filter
  - Labels filter

### Text input filter
This filter works in two different modes
- Regex
  * In this mode performs case insensitive and is the value contains search
- Is In
  * When supplying same option filter more than once, filter mode for that field switch to **Is In** 
  * Verifies that particular field has one of the input
![filter2](/doc-images/mc_filter2.png)

### Selection filter
This filter works same as [Text input filter](#text-input-filter)

### Labels filter
Label filter is a special filter used to filter a resource by labels.<br>
You can supply label in the format of `key=value`<br>

Examples:
- location=external
- zone=south
- version=2.0.2

## Action Buttons
* By selection one or more number of row, the action buttons drop down will be enabled
* Selecting an action on the dropdown apply to all the selected resources<br>
  ![action_buttons](/doc-images/mc_action_buttons.png)<br>

## Quick Buttons
* Couple of quick buttons will be on the toolbar
  * ![refresh button](/doc-images/mc_refresh_button.png) - Refresh button, reloads the resources from the server
  * ![add button](/doc-images/mc_add_button.png) - Add button, takes to add resource page
