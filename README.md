# Park an active voice call with a code and retrieve it using the code

This Genesys Cloud Developer Blueprint explains how to set up Genesys Cloud to park an active voice call with a code and retrieve it using the code.

When an Genesys Cloud user transfers an active call to an in-queue flow with a code, the call can be retrieved from another phone, station or user using the code associated with that call.

![Call Park Genesys Cloud flow](blueprint/images/call-park-workflow.png "Genesys Cloud Call Park")

The following illustration shows the end-to-end user experience that this solution enables.

![End-to-end user experience](blueprint/images/CallParkingMid.gif "End-to-end user experience")

:::primary
  **Note:** This example above shows a call being retrieved from a Google Voice number.  A call can also be retrieved by a Genesys Cloud user from the Genesys Cloud platform.  A Genesys Cloud user could also consider sending the retrieval code to the desired Genesys Cloud user via a GC Collaborate Chat or SMS.  An example message could be: "you have a parked call. dial 3172222222,,,,,123 to retrieve the parked call."
  :::
