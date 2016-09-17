public abstract class mws_Response {
  public Dom.Document dom {get; set;}
  public String requestId {get; set;}
  
  protected mws_Response(Dom.Document dom) {
    this.dom = dom;
    
    Dom.XmlNode root = dom.getRootElement();
    if (root.getName().equals('ErrorResponse')) {
      throw new mws_ErrorResponseException(dom);
    }
    
    Dom.XmlNode meta = mws_DomUtil.child(root, 'ResponseMetadata');
    requestId = mws_DomUtil.string(meta, 'RequestId');
  }
}