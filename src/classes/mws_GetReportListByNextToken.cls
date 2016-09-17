public class mws_GetReportListByNextToken extends mws_Request {
  public String nextToken {get; set;}
  
  public mws_GetReportListByNextToken(String nextToken) {
    super('Reports', '2009-01-01', 'GetReportListByNextToken');
    this.nextToken = nextToken;
  }
  
  public override void setupParams(Map<String, Object> params) {
    System.assertNotEquals(null, nextToken);
    params.put('NextToken', nextToken);
  }

  public override Object handleResponse(HttpResponse response) {
    return new mws_GetReportListResponse(response.getBodyDocument(), 'GetReportListByNextTokenResult');
  }
}