## Using Deadlines and Deadline Alerts in Rally

In Rally, deadlines can be set for assets to ensure their timely completion. 
Additionally, you can configure `Deadline Alerts` to receive notifications before a deadline is reached.

Official Documentation: [Using Deadlines and Deadline Alerts in Rally](https://sdvi.my.site.com/support/s/article/Using-Deadlines-and-Deadline-Alerts-in-Rally)

# Additional Information
## Add a Deadline to an Asset via API
You can add a deadline to an asset during the creation or the update of the asset via API.
[Asset API documentation](https://partner.sdvi.com/apidocs/index.html#resource-reference-assets)

Use `POST /assets` to create an asset from scratch, use `PATCH /assets/:id` to update an existing one.

**Note**: The asset deadline (data.attributes.deadline) has to be in epoch milliseconds format for the API call.




