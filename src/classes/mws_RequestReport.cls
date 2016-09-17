/**
 * http://docs.developer.amazonservices.com/en_US/reports/Reports_RequestReport.html
 */
public class mws_RequestReport extends mws_Request {
  public mws_ReportType reportType {get; set;}
  public DateTime startDate {get; set;}
  public DateTime endDate {get; set;}
  public String reportOptions {get; set;}
  public List<String> marketplaceIdList {get; set;}
  
  public mws_RequestReport(mws_ReportType reportType) {
    super('Reports', '2009-01-01', 'RequestReport');
    this.reportType = reportType;
  }

  public override void setupParams(Map<String, Object> params) {
    System.assertNotEquals(null, reportType);
    
    params.put('ReportType', reportType);
    if (startDate != null) params.put('StartDate', startDate);
    if (endDate != null) params.put('EndDate', endDate);
    if (reportOptions != null) params.put('ReportOptions', reportOptions);
    if (marketplaceIdList != null) params.put('MarketplaceIdList', marketplaceIdList);
  }

  public override Object handleResponse(HttpResponse response) {
    return new mws_RequestReportResponse(response.getBodyDocument());
  }
}