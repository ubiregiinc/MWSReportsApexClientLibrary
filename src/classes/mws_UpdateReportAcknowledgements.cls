public class mws_UpdateReportAcknowledgements extends mws_Request {
  public List<String> reportIdList {get; set;}
  public Boolean acknowledged {get; set;}
  
  public mws_UpdateReportAcknowledgements(List<String> reportIdList) {
    super('Reports', '2009-01-01', 'UpdateReportAcknowledgements');
    this.reportIdList = reportIdList;
  }
  
  public override void setupParams(Map<String, Object> params) {
    System.assertNotEquals(null, reportIdList);
    
    params.put('ReportIdList', reportIdList);
    if (acknowledged != null) params.put('Acknowledged', acknowledged);
  }

  public override Object handleResponse(HttpResponse response) {
    return new mws_GetReportListResponse(response.getBodyDocument(), 'UpdateReportAcknowledgementsResult');
  }
}