public class mws_ErrorResponseException extends Exception {
  /*
  <?xml version="1.0"?>
  <ErrorResponse xmlns="http://mws.amazonaws.com/doc/2009-01-01/">
    <Error>
      <Type>Sender</Type>
      <Code>InvalidParameterValue</Code>
      <Message>Either Action or Operation query parameter must be present.</Message>
    </Error>
    <RequestID>2bdad039-6bfa-44ce-9933-146e38e8148e</RequestID>
  </ErrorResponse>
  */
  public List<mws_Error> errors {get; set;}
  public String requestID {get; set;}
  
  public mws_ErrorResponseException(Dom.Document dom) {
    Dom.XmlNode root = dom.getRootElement();
    
    errors = new List<mws_Error>();
    for (Dom.XmlNode n : mws_DomUtil.children(root, 'Error')) {
      errors.add(new mws_Error(n));
    }
    
    requestID = mws_DomUtil.string(root, 'RequestID');
    
    if (errors.size() > 0) {
      setMessage(errors.get(0).message);
    }
  }
}