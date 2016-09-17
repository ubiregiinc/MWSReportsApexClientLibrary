/*
  <ReportInfo>
    <ReportId>898899473</ReportId>
    <ReportType>_GET_MERCHANT_LISTINGS_DATA_</ReportType>
    <ReportRequestId>2278662938</ReportRequestId>
    <AvailableDate>2009-02-10T09:22:33+00:00</AvailableDate>
    <Acknowledged>false</Acknowledged>
  </ReportInfo>
  */
public class mws_ReportInfo {
  public String reportId {get; set;}
  public mws_ReportType reportType {get; set;}
  public String reportRequestId {get; set;}
  public DateTime availableDate {get; set;}
  public Boolean acknowledged {get; set;}
  public DateTime acknowledgedDate {get; set;}
  
  public mws_ReportInfo(Dom.XmlNode node) {
    reportId = mws_DomUtil.string(node, 'ReportId');
    reportType = mws_DomUtil.reportType(node, 'ReportType');
    reportRequestId = mws_DomUtil.string(node, 'ReportRequestId');
    availableDate = mws_DomUtil.datetime(node, 'AvailableDate');
    acknowledged = mws_DomUtil.boolean(node, 'Acknowledged');
    acknowledgedDate = mws_DomUtil.datetime(node, 'AcknowledgedDate');
  }
}