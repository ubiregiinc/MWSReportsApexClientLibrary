@isTest
public class mws_UpdateReportAcknowledgementsTest {
  static mws_Client client;
  
  static void setup() {
    client = new mws_Client('https://mws.amazonservices.jp', 'access_key', 'secret');
    client.sellerId = 'seller';
  }
  
  static testMethod void test() {
    setup();
    
    mws_HttpCalloutMock httpMock = new mws_HttpCalloutMock();
    Test.setMock(HttpCalloutMock.class, httpMock);
    
    httpMock.response = new HttpResponse();
    httpMock.response.setBody('<?xml version="1.0"?>' +
			'<UpdateReportAcknowledgementsResponse' +
			'  xmlns="http://mws.amazonaws.com/doc/2009-01-01/">' +
			'  <UpdateReportAcknowledgementsResult>' +
			'    <Count>1</Count>' +
			'    <ReportInfo>' +
			'      <ReportId>841997483</ReportId>' +
			'      <ReportType>_GET_MERCHANT_LISTINGS_DATA_</ReportType>' +
			'      <ReportRequestId>2234038326</ReportRequestId>' +
			'      <AvailableDate>2009-01-06T03:48:36+00:00</AvailableDate>' +
			'      <Acknowledged>true</Acknowledged>' +
			'      <AcknowledgedDate>2009-02-20T02:10:41+00:00</AcknowledgedDate>' +
			'    </ReportInfo>' +
			'  </UpdateReportAcknowledgementsResult>' +
			'  <ResponseMetadata>' +
			'    <RequestId>42a578a7-ed92-486b-ac67-5de7464fcdfa</RequestId>' +
			'  </ResponseMetadata>' +
			'</UpdateReportAcknowledgementsResponse>');
    
    Test.startTest();
    
    mws_UpdateReportAcknowledgements action = new mws_UpdateReportAcknowledgements(new String[] {'test'});
    mws_GetReportListResponse response = (mws_GetReportListResponse) client.send(action);
    
    System.assertEquals(1, response.reports.size());
    mws_ReportInfo report = response.reports.get(0);
    System.assertEquals('841997483', report.reportId);
    System.assertEquals(mws_ReportType.GET_MERCHANT_LISTINGS_DATA, report.reportTYpe);
    System.assertEquals('2234038326', report.reportRequestId);
    System.assertEquals(DateTime.newInstanceGmt(2009, 1, 6, 3, 48, 36), report.availableDate);
    System.assertEquals(true, report.acknowledged);
    System.assertEquals(DateTime.newInstanceGmt(2009, 2, 20, 2, 10, 41), report.acknowledgedDate);
    
    Test.stopTest();
  }
}