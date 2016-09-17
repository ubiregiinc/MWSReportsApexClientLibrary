# MWSReportsApexClientLibrary ![ci-status](https://circleci.com/gh/ubiregiinc/MWSReportsApexClientLibrary.png?style=shield&circle-token=4795b9bf49b5e591b7943a4d02616faae6537916)
Apex client for Amazon Marketplace Web Service (Amazon MWS) Reports API (version 2009-01-01)

API reference: http://docs.developer.amazonservices.com/en_US/reports/

# Supported action
Currently following operations are implemented.

- [RequestReport](http://docs.developer.amazonservices.com/en_US/reports/Reports_RequestReport.html)
- [GetReportList](http://docs.developer.amazonservices.com/en_US/reports/Reports_GetReportList.html)
- [GetReportListByNextToken](http://docs.developer.amazonservices.com/en_US/reports/Reports_GetReportListByNextToken.html)
- [GetReport](http://docs.developer.amazonservices.com/en_US/reports/Reports_GetReport.html)
- [UpdateReportAcknowledgements](http://docs.developer.amazonservices.com/en_US/reports/Reports_UpdateReportAcknowledgements.html)

# Usage
```apex
// setup mws_Client with 
//  - API endpoint (see http://docs.developer.amazonservices.com/en_US/dev_guide/DG_Endpoints.html)
//  - AWS Access Key ID
//  - Secret Key
mws_Client client = new mws_Client('https://mws.amazonservices.jp', 'access_key', 'secret');

// set your Seller ID
client.sellerId = 'seller';

// create request with required parameter(s)
mws_RequestReport action = new mws_RequestReport('_GET_AMAZON_FULFILLED_SHIPMENTS_DATA_');

// optionally set parameter(s)
// action.endDate = DateTime.now();

// send request with the client and consume the response
mws_RequestReportResponse response = (mws_RequestReportResponse) client.send(action);
```

