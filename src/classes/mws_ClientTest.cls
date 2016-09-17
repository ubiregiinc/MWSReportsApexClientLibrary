@isTest
public class mws_ClientTest {
  static testMethod void testSignature() {
    mws_Client client = new mws_Client('https://mws.amazonservices.jp', 'access_key', 'secret');
    client.sellerId = 'seller';
    
    Map<String, Object> params = client.defaultParams();
    DateTime timestamp = DateTime.newInstanceGmt(2016, 9, 10, 13, 50, 35);
    params.put('Timestamp', timestamp);
    
    params.put('Version', '2009-01-01');
    params.put('Action', 'GetReportList');
    params.put('Marketplace', 'A1VC38T7YXB528');
    params.put('ReportId', '392709651017045');
    params.put('ReportTypeList', new mws_ReportType[] {mws_ReportType.GET_AMAZON_FULFILLED_SHIPMENTS_DATA});
    
    String queryString = client.signedQueryString(params, '/Reports/2009-01-01/');
    System.assertEquals('AWSAccessKeyId=access_key&Action=GetReportList&Marketplace=A1VC38T7YXB528&ReportId=392709651017045&ReportTypeList.Id.1=_GET_AMAZON_FULFILLED_SHIPMENTS_DATA_&SellerId=seller&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2016-09-10T13%3A50%3A35Z&Version=2009-01-01&Signature=ooPzAdJeTjyJscWKgsu%2FgPEjF2GVDl1KgY%2F49CLlZ3k%3D', queryString);
    
    String u = client.signedURL('Reports', '2009-01-01', params);
    System.assertEquals('https://mws.amazonservices.jp/Reports/2009-01-01/?AWSAccessKeyId=access_key&Action=GetReportList&Marketplace=A1VC38T7YXB528&ReportId=392709651017045&ReportTypeList.Id.1=_GET_AMAZON_FULFILLED_SHIPMENTS_DATA_&SellerId=seller&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2016-09-10T13%3A50%3A35Z&Version=2009-01-01&Signature=ooPzAdJeTjyJscWKgsu%2FgPEjF2GVDl1KgY%2F49CLlZ3k%3D', u);
  }
}