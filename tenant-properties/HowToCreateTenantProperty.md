**How to create a Tenant Property**
===============================

 

In this article we are going to see how to create a Tenant Property.

 

This new tenant property will contain a json object with an array of URLs that
we could use in our site collections.

 

Lets create it the steps it shows below.

 

First of all, run **SharePoint Online Management Shell**, invoking the the
following command to connect to our SharePoint Administration site:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Connect-SPOService https://yourtenant-admin.sharepoint.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this case we are not providing any user information, so then we need to
provide our tenant admin user credentials in the sign in form.

The command to create a new tenant property is the following:

`Set-SPOStorageEntity [-Site] [-Key] [-Value] [-Description] [-Comments]`

The command parameters it explains below:

**Site**: It must be the site collection app catalog. E.g.: https://yourtenant.sharepoint.com/sites/apps-catalog

**Key**: string to get the tenant property. E.g.: global-navigation-test

**Value**: in this case would be a json like this:

```
[
 {
 "name": "News",
 "url": "https://yourtenant.sharepoint.com/sites/news",
 "description": "Corporate Company News Portal",
 "target": ""
 },
 {
 "name": "Human Resources",
 "url": "https://yourtenant.sharepoint.com/sites/hr",
 "description": "Human Resources Portal",
 "target": ""
 },
 {
 "name": "Learning",
 "url": "https://yourtenant.sharepoint.com/sites/learning",
 "description": "Learning Portal",
 "target": ""
 }
]
```

It’s very important that if you need to set a json to a tenant property, you
must **minify** it, otherwise you have an error indicating that the value is not
correct. In our case, this json would use like this:

```
[{"name":"News","url":"https://yourtenant.sharepoint.com/sites/news","description":"Corporate Company News Portal","target":""},{"name":"Human Resources","url":"https://yourtenant.sharepoint.com/sites/hr","description":"Human Resources Portal","target":""},{"name":"Learning","url":"https://yourtenant.sharepoint.com/sites/learning","description":"Learning Portal","target":""}]
```

**Description**: A brief description for the tenant property

**Comments**: Comments related with the tenant property

The command for this case would be like the following:

```
Set-SPOStorageEntity -Site https://yourtenant.sharepoint.com/sites/apps-catalog -Key global-navigation-test -Value '[{"name":"News","url":"https://yourtenant.sharepoint.com/sites/news","description":"Corporate Company News Portal","target":""},{"name":"Human Resources","url":"https://yourtenant.sharepoint.com/sites/hr","description":"Human Resources Portal","target":""},{"name":"Learning","url":"https://yourtenant.sharepoint.com/sites/learning","description":"Learning Portal","target":""}]' -Description 'Tenant Property Description' -Comments 'Tenant Property Comments'
```

You can check if the tenant property was created using the following command:

`Get-SPOStorageEntity -Site https://yourtenant.sharepoint.com/sites/apps-catalog -Key global-nav
igation-test`

The result would be the following:
```
Comment            : Tenant Property Comments
Description        : Tenant Property Description
Value              : [{"name":"News","url":"https://yourtenant.sharepoint.com/sites/news","description":"Corporate
                     Company News Portal","target":""},{"name":"Human
                     Resources","url":"https://yourtenant.sharepoint.com/sites/hr","description":"Human Resources Porta
                     l","target":""},{"name":"Learning","url":"https://yourtenant.sharepoint.com/sites/learning","descr
                     iption":"Learning Portal","target":""}]
Context            : Microsoft.Online.SharePoint.PowerShell.CmdLetContext
Tag                :
Path               : Microsoft.SharePoint.Client.ObjectPathMethod
ObjectVersion      :
ServerObjectIsNull : False
TypedObject        : Microsoft.SharePoint.ClientSideComponent.StorageEntity
```
Well, as you can see is very easy create a tenant property, now we can use this property in our site collections.
