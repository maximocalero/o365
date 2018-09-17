**Office 365 Tenant Properties**
================================

In SharePoint it's very probable that we need share some information among several site
collections, like Id values, URLs we need access from each site collection, or
json object with a some complex information.

That information could be in a list in a site collection that would act like a
common configuration sites but in SharePoint Online we would have some aspects
to consider related with performance.

In on premise environment we had the option to work with **Properties Bag**, in
SharePoint Online if we want something similar we need to work with **Tenant
Properties**.

Lets see a possible case to apply in our SharePoint site collections.

We need to implement a common menu across site collections, we would have
several options to this:

-   Have a list in a configuration site collection (E.g.: the content type site
    collection: https://yourtenant.sharepoint.com/contenttypehub)

-   Have a TermSet in the Termstore where each term would be an URL.

-   Have a Tenant Property with a json with these URLs.

The last one is the best for me, once you create this Tenant Property, you will be able to access to this information from all site collections using a REST API method. In adition, you avoid to have to provision some assets like a list or a TermSet.

>**Note:** Some points of interest:  
>* I didn't find any information about the limit values, it's possible has to do with the limits we have in a column of a list (as soon I know this I will update this article)   
>* Is not only related with SharePoint Framework. These Tenant Properties could be used in classic solutions.
>* Don't store any confidential information  like passwords, connection strings or whatever it would be a security problem for your organization
>* I want to create a comparative article with these possibilities (List, TermSet or Tenant Property) to stablish what it's the better option to access a configuration like it's exposed in this example. I will also update this repository with this comparative article. 


In this GitHub repository you could access to different articles to work with
Tenant Properties:

[How to create a Tenant Property](HowToCreateTenantProperty.md)

[PowerShell scripts to create and remove Tenant Properties](PowerShellScriptsTenantProperties.md)


Requirements
------------

### SharePoint Online Management Shell
To create Tenant Properties (as well as other SharePoint online commands) you need to install *SharePoint Online Management Shell*, a tool that have PowerShell Module to administrate SharePoint Online. The link to download this tool is the following:  
[SharePoint Online Management
Shell](https://www.microsoft.com/en-US/download/details.aspx?id=35588)

### Connect-SPOService command and SharePoint Online global administrator User  
To be able to execute commands like we have in this repository we are going to need execute Connect-SPOService command to get a SharePoint online connection against our SharePoint online administration. This means that we will need an SharePoint Online global administrator User. In the following link you can access to the Connect-SPOService documentation:  
[Connect-SPOService](https://docs.microsoft.com/en-us/powershell/module/sharepoint-online/connect-sposervice?view=sharepoint-ps)

### Site collection App Catalog is required  
Tenant Properties are stored in an App Catalog. We must to create a site collection App Catalog in our SharePoint online environment to be able to create these Tenant Properties. In the following link you can see how to create an App Catalog for SharePoint online (Step 1):  
[Use the App Catalog to make custom business apps available for your SharePoint Online environment](https://docs.microsoft.com/en-us/sharepoint/use-app-catalog)

Other insteresting links
------------------------


There is a short video of SharePoint PnP Team that you can see an introduction of Tenant Properties  
[SharePoint PnP Webcast – Working with Tenant Properties in SharePoint Online](https://developer.microsoft.com/en-us/office/blogs/working-with-tenant-properties-in-sharepoint-online/)

