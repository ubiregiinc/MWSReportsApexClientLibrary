public abstract class mws_Request {
  public String resource {get; set;}
  public String version {get; set;}
  public String action {get; set;}
  
  protected mws_Request(String resource, String version, String action) {
    this.resource = resource;
    this.version = version;
    this.action = action;
  }
  
  public HttpRequest toRequest(mws_Client client) {
    Map<String, Object> params = client.defaultParams();
    params.put('Version', version);
    params.put('Action', action);
    setupParams(params);
    
    for (String key : params.keySet()) {
      if (params.get(key) == null) {
        params.remove(key);
      }
    }
    
    String endpoint = client.signedURL(resource, version, params);
    
    HttpRequest req = new HttpRequest();
    req.setMethod('GET');
    req.setEndpoint(endpoint);
    return req;
  }
  
  protected abstract void setupParams(Map<String, Object> params);
  
  public abstract Object handleResponse(HttpResponse response);
}