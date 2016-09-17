@isTest
public class mws_GetReportListTest {
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
    httpMock.response.setBody('<?xml version="1.0"?>\n' +
			'<GetReportListResponse xmlns="http://mws.amazonaws.com/doc/2009-01-01/">\n' +
			'  <GetReportListResult>\n' +
			'    <NextToken>2YgYW55IPQhvu5hbCBwbGVhc3VyZS4=</NextToken>\n' +
			'    <HasNext>true</HasNext>\n' +
			'    <ReportInfo>\n' +
			'      <ReportId>898899473</ReportId>\n' +
			'      <ReportType>_GET_MERCHANT_LISTINGS_DATA_</ReportType>\n' +
			'      <ReportRequestId>2278662938</ReportRequestId>\n' +
			'      <AvailableDate>2009-02-10T09:22:33+00:00</AvailableDate>\n' +
			'      <Acknowledged>false</Acknowledged>\n' +
			'    </ReportInfo>\n' +
			'  </GetReportListResult>\n' +
			'  <ResponseMetadata>\n' +
			'    <RequestId>fbf677c1-dcee-4110-bc88-2ba3702e331b</RequestId>\n' +
			'  </ResponseMetadata>\n' +
			'</GetReportListResponse>');
    
    Test.startTest();
    
    mws_GetReportList action = new mws_GetReportList();
    mws_GetReportListResponse response = (mws_GetReportListResponse) client.send(action);
    
    System.assertEquals('2YgYW55IPQhvu5hbCBwbGVhc3VyZS4=', response.nextToken);
    System.assertEquals(true, response.hasNext);
    System.assertEquals(1, response.reports.size());
    mws_ReportInfo report = response.reports.get(0);
    System.assertEquals('898899473', report.reportId);
    System.assertEquals('_GET_MERCHANT_LISTINGS_DATA_', report.reportTYpe);
    System.assertEquals('2278662938', report.reportRequestId);
    System.assertEquals(DateTime.newInstanceGmt(2009, 2, 10, 9, 22, 33), report.availableDate);
    System.assertEquals(false, report.acknowledged);
    System.assertEquals(null, report.acknowledgedDate);
    
    Test.stopTest();
  }
}