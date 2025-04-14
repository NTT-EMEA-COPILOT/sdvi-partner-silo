# Chapter-10: Rally Gateway workorder
We are going to create a workorder to be used in the Rally Gateway with a custom form.

## Create work order from preset
Create a new preset selecting the `Rally Gateway Work Order` provider type as in the following screenshot

![Create Work Order Preset](./images/create_wo_preset.png)

Open the preset editor and fill the form with the following (referenced also [here as JSON file](workorder.json)):

```json
{
  "gateway": {
    "markdown": {
      "TechMarkdown": [
        "{{ DYNAMIC_PRESET_DATA['message'] }}"
      ]
    },
    "schemas": {
      "techValidation": {
        "displayRules": [
          {
            "type": "markdown",
            "value": "### Failure reason(s)\n{{ DYNAMIC_PRESET_DATA['message'] }}"
          },
          {
            "enum": [
              "Reject File",
              "Ingest anyway",
              "Send to Leeds"
            ],
            "presentation": {
              "type": "radio"
            },
            "schemaProperty": "NextAction"
          },
          {
            "schemaProperty": "Comments"
          }
        ],
        "schema": {
          "$id": "md-1",
          "properties": {
            "Allow Existing Asset for Critical Delivery": {
              "default": false,
              "title": "Allow Existing Asset for Critical Delivery",
              "type": "boolean"
            },
            "Comments": {
              "title": "Comments",
              "type": [
                "string"
              ]
            },
            "NextAction": {
              "title": "Next action",
              "type": [
                "string"
              ]
            }
          },
          "required": [
            "NextAction"
          ],
          "title": "Tech Validation",
          "type": "object"
        }
      }
    }
  }
}
```

## Create your work order page
Enter the gateway page created in chapter 10 and create a new portal page.


### Workorder widget
Add a work order widget to the page selecting the `Work Order` -the last one- option from the available widgets list

![Create Work Order Widget](./images/add_wo_list_widget.png)

Fill the form with:
* Name
* Work Order Provider
* Presets
* Allowed Actions
and click the `Create` button

![Work Order Widget](./images/wo_widget_creation.png)

### Metadata Edit widget
Add a metadata edit widget to the page selecting the `Metadata Edit` option from the available widgets list

![Create ME Widget](./images/create_me_widget.png)

Note:
* select `Work Order Mode` as **Metadata Schema**
* set `techValidation` as **Schema Name**

Your page should look like this:
![Empty Widget Page](./images/custom_form_wo_empty_page.png)

## Create a work order
