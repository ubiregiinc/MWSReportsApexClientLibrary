public class mws_GetReportList extends mws_Request {
  public Integer maxCount {get; set;}
  public List<mws_ReportType> reportTypeList {get; set;}
  public Boolean acknowledged {get; set;}
  public DateTime availableFromDate {get; set;}
  public DateTime availableToDate {get; set;}
  public List<String> reportRequestIdList {get; set;}

  public mws_GetReportList() {
    super('Reports', '2009-01-01', 'GetReportList');
  }

  public override void setupParams(Map<String, Object> params) {
    params.put('MaxCount', maxCount);
    params.put('ReportTypeList', reportTypeList);
    params.put('Acknowledged', acknowledged);
    params.put('AvailableFromDate', availableFromDate);
    params.put('AvailableToDate', availableToDate);
    params.put('ReportRequestIdList', reportRequestIdList);
  }

  public override Object handleResponse(HttpResponse response) {
    return new mws_GetReportListResponse(response.getBodyDocument(), 'GetReportListResult');
  }
}