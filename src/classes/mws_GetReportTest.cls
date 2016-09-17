@isTest
class mws_GetReportTest {
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
    httpMock.response.setBody('test');
    
    Test.startTest();
    
    mws_GetReport action = new mws_GetReport('report_id');
    String response = (String) client.send(action);
    
    System.assertEquals('test', response);
    
    Test.stopTest();
  }
}