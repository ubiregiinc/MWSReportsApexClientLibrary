public class mws_GetReport extends mws_Request {
  public String reportId {get; set;}
  
  public mws_GetReport(String reportId) {
    super('Reports', '2009-01-01', 'GetReport');
    this.reportId = reportId;
  }

  public override void setupParams(Map<String, Object> params) {
    System.assertNotEquals(null, reportId);
    params.put('ReportId', reportId);
  }

  public override Object handleResponse(HttpResponse response) {
    return response.getBody();
  }
}