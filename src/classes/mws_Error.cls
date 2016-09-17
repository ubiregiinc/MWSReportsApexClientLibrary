public class mws_Error {
  public String type {get; set;}
  public String code {get; set;}
  public String message {get; set;}
  public String detail {get; set;}
  
  public mws_Error(Dom.XmlNode error) {
    type = mws_DomUtil.string(error, 'Type');
    code = mws_DomUtil.string(error, 'Code');
    message = mws_DomUtil.string(error, 'Message');
    detail = mws_DomUtil.string(error, 'Detail');
  }
}