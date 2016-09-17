@isTest
public class mws_RequestReportTest {
  static mws_Client client;
  
  static void setup() {
    client = new mws_Client('https://mws.amazonservices.jp', 'access_key', 'secret');
    client.sellerId = 'seller';
  }
  
  static testMethod void testResponse() {
    setup();
    
    mws_HttpCalloutMock httpMock = new mws_HttpCalloutMock();
    Test.setMock(HttpCalloutMock.class, httpMock);
    
    httpMock.response = new HttpResponse();
    httpMock.response.setBody('<?xml version="1.0"?>\n' +
      '<RequestReportResponse xmlns="http://mws.amazonaws.com/doc/2009-01-01/">\n' +
      '  <RequestReportResult>\n' +
      '    <ReportRequestInfo>\n' +
      '      <ReportRequestId>2291326454</ReportRequestId>\n' +
      '      <ReportType>_GET_MERCHANT_LISTINGS_DATA_</ReportType>\n' +
      '      <StartDate>2009-01-21T02:10:39+00:00</StartDate>\n' +
      '      <EndDate>2009-02-13T02:10:39+00:00</EndDate>\n' +
      '      <Scheduled>false</Scheduled>\n\n' +
      '      <SubmittedDate>2009-02-20T02:10:39+00:00</SubmittedDate>\n' +
      '      <ReportProcessingStatus>_SUBMITTED_</ReportProcessingStatus>\n' +
      '    </ReportRequestInfo>\n' +
      '  </RequestReportResult>\n' +
      '  <ResponseMetadata>\n' +
      '    <RequestId>88faca76-b600-46d2-b53c-0c8c4533e43a</RequestId>\n' +
      '  </ResponseMetadata>\n' +
      '</RequestReportResponse>');
    
    Test.startTest();
    
    mws_RequestReport action = new mws_RequestReport('_GET_AMAZON_FULFILLED_SHIPMENTS_DATA_');
    mws_RequestReportResponse response = (mws_RequestReportResponse) client.send(action);
    
    System.assertEquals('2291326454', response.reportRequestId);
    System.assertEquals('_GET_MERCHANT_LISTINGS_DATA_', response.reportType);
    System.assertEquals(DateTime.newInstanceGmt(2009, 1, 21, 2, 10, 39), response.startDate);
    System.assertEquals(DateTime.newInstanceGmt(2009, 2, 13, 2, 10, 39), response.endDate);
    System.assertEquals(false, response.scheduled);
    System.assertEquals(DateTime.newInstanceGmt(2009, 2, 20, 2, 10, 39), response.submittedDate);
    System.assertEquals('_SUBMITTED_', response.reportProcessingStatus);
    System.assertEquals('88faca76-b600-46d2-b53c-0c8c4533e43a', response.requestId);
    
    Test.stopTest();
  }
  
  static testMethod void testErrorResponse() {
    setup();
    
    mws_HttpCalloutMock httpMock = new mws_HttpCalloutMock();
    Test.setMock(HttpCalloutMock.class, httpMock);
    
    httpMock.response = new HttpResponse();
    httpMock.response.setBody('<?xml version="1.0"?>\n' +
      '<ErrorResponse xmlns="http://mws.amazonaws.com/doc/2009-01-01/">\n' +
      '<Error>\n' +
      '  <Type>Sender</Type>\n' +
      '  <Code>InvalidParameterValue</Code>\n' +
      '  <Message>Either Action or Operation query parameter must be present.</Message>\n' +
      '</Error>\n' +
      '<RequestID>2bdad039-6bfa-44ce-9933-146e38e8148e</RequestID>\n' +
      '</ErrorResponse>');
      
    Test.startTest();
    
    mws_RequestReport action = new mws_RequestReport('_GET_AMAZON_FULFILLED_SHIPMENTS_DATA_');
    
    try {
      mws_RequestReportResponse response = (mws_RequestReportResponse) client.send(action);
      System.assert(false, 'should throw ErrorResponseException');
    } catch (mws_ErrorResponseException ex) {
      System.assertEquals(1, ex.errors.size());
      mws_Error err = ex.errors.get(0);
      System.assertEquals('Sender', err.type);
      System.assertEquals('InvalidParameterValue', err.code);
      System.assertEquals('Either Action or Operation query parameter must be present.', err.message);
      System.assertEquals('Either Action or Operation query parameter must be present.', ex.getMessage());
      System.assertEquals('2bdad039-6bfa-44ce-9933-146e38e8148e', ex.requestID);
    }
    
    Test.stopTest();
  }
}