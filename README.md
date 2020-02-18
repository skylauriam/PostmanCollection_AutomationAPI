# PostmanCollection_AutomationAPI
This repository has been created to collect all file related to postman collection in CI

### Agenda 

- Quick Postman Overview
- Objectives 
- How to create a correct Data input file 
- Postman Collection | A common strategy 
- Next Steps 
 
### Quick Postman Overview 

The aim of the Postman Collection is to allow the BE functional validation. This validation can be performed in two different ways. The first one using a manual approach (manual trigger of the script execution). The second one is related to have continuous integration regarding various working environments (best approach). It has to be dynamic and run a customized workflow on the basis of different inputs coming from environment and data files. 
 
### Objectives 

The target is to insert the postman collection in a continuous integration (CI) process. That said, for each new back-end build of the software, the collection could be run to check for services integrity and make sure the entire system is working fine before release. 
 
### How to create a correct Data input file 

The postman collection requires input files to run properly.  
There are two files used: environment file, which is mandatory, and external data file, facultative. 
 
The environment file contains a set of variables which are used by every single request, useful for building the URL or giving the data in the request's body, as examples. This file is mandatory to run the collection as is. 
 
The external data file is facultative, it's consider a support to eventually iterate the collection with different datas. 
Actually, it's only used for the integrated environments, where is required a customized workflow of requests since not everyone can be run correctly.  
 
The actual external data file for test contains an array of objects which contains two different keys/values : one is for the actual request which to check during the run, the other contains the name of the next Request to set in the workflow. 
Following an example of the structure used: 
 

```json
[{ 
"RequestFlow" : [ 
{"Actual":"request_1","NextRequest":"request_2"}, 
{"Actual":"request_2","NextRequest":"request_3"}, 
{"Actual":"request_3","NextRequest":" "} 
] 
}] 
``` 

This external data file is used in a pre-request script, which is run for every request, that cycles the entire list thanks to a forEach method, to find if the following request is contained in the "white-list" and can be run or instead has to be skipped. 
 
### Postman Collection | A common strategy 

The collection contains a variety of requests that check the health of the BE services.  
 
The top-level folder contains two sub-folders, one for an authentication request (we will see later what's about and why it's required) and the other one that contains all the remaining requests. 
This top-level folder runs a pre-request script that is iterated for each requests; it checks for the environment on which the postman collection is running and creates a custom workflow of requests: 
Local/Dev environments: every request is ran since it's a mocked environment and can run everything in the collection. 
Test/UAT/PreProd/Prod environments: custom flow, small part of the requests can be ran because it's an integrated environment and users can be badly modified if some writing requests are ran, blocking a future iteration of the collection. Here the external data file is used to have the correct route to follow.  
 
As said, one of the two sub-folder is for the authentication in test environment, since it's integrated and need continuously to update a bearer token to have the right permissions for each request that has to be ran. 
 
The rest of requests are divided into folders with the name of the API under test :
```json
API Name : [ServiceName]_[StatusCodeExpected]
``` 

At this moment, each request contains one or more test after it is sent to the API, from "response code" check, to functional check of the response.
