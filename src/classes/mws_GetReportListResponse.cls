/*
<?xml version="1.0"?>
<GetReportListResponse xmlns="http://mws.amazonaws.com/doc/2009-01-01/">
  <GetReportListResult>
    <NextToken>2YgYW55IPQhvu5hbCBwbGVhc3VyZS4=</NextToken>
    <HasNext>true</HasNext>
    <ReportInfo>
      <ReportId>898899473</ReportId>
      <ReportType>_GET_MERCHANT_LISTINGS_DATA_</ReportType>
      <ReportRequestId>2278662938</ReportRequestId>
      <AvailableDate>2009-02-10T09:22:33+00:00</AvailableDate>
      <Acknowledged>false</Acknowledged>
    </ReportInfo>
  </GetReportListResult>
  <ResponseMetadata>
    <RequestId>fbf677c1-dcee-4110-bc88-2ba3702e331b</RequestId>
  </ResponseMetadata>
</GetReportListResponse>
 */
public class mws_GetReportListResponse extends mws_Response {
  public String nextToken {get; set;}
  public Boolean hasNext {get; set;}
  public List<mws_ReportInfo> reports {get; set;}
  
  public mws_GetReportListResponse(Dom.Document dom, String name) {
    super(dom);
    
    Dom.XmlNode root = dom.getRootElement();
    Dom.XmlNode result = mws_DomUtil.child(root, name);
    System.assertNotEquals(null, result);
    nextToken = mws_DomUtil.string(result, 'NextToken');
    hasNext = mws_DomUtil.boolean(result, 'HasNext');
    
    reports = new List<mws_ReportInfo>();
    for (Dom.XmlNode n : mws_DomUtil.children(result, 'ReportInfo')) {
      reports.add(new mws_ReportInfo(n));
    }
  }
}