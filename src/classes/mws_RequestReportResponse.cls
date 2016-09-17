/**
 * http://docs.developer.amazonservices.com/en_US/reports/Reports_RequestReport.html
 */
public class mws_RequestReportResponse extends mws_Response {
  public String reportRequestId {get; set;}
  public mws_ReportType reportType {get; set;}
  public DateTime startDate {get; set;}
  public DateTime endDate {get; set;}
  public Boolean scheduled {get; set;}
  public DateTime submittedDate {get; set;}
  public String reportProcessingStatus {get; set;}
  
  public mws_RequestReportResponse(Dom.Document dom) {
    super(dom);
    
    Dom.XmlNode root = dom.getRootElement();
    
    Dom.XmlNode requestReportResult = mws_DomUtil.child(root, 'RequestReportResult');
    Dom.XmlNode reportRequestInfo = mws_DomUtil.child(requestReportResult, 'ReportRequestInfo');
    
    reportRequestId = mws_DomUtil.string(reportRequestInfo, 'ReportRequestId');
    reportType = mws_DomUtil.reportType(reportRequestInfo, 'ReportType');
    startDate = mws_DomUtil.datetime(reportRequestInfo, 'StartDate');
    endDate = mws_DomUtil.datetime(reportRequestInfo, 'EndDate');
    scheduled = mws_DomUtil.boolean(reportRequestInfo, 'Scheduled');
    submittedDate = mws_DomUtil.datetime(reportRequestInfo, 'SubmittedDate');
    reportProcessingStatus = mws_DomUtil.string(reportRequestInfo, 'ReportProcessingStatus');
  }
}