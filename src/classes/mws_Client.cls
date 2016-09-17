public class mws_Client {
  public String awsAccessKeyId {get; set;}
  public String awsSecretAccessKey {get; set;}
  public String serviceURL {get; set;}
  public String userAgent {get; set;}
  public String signatureMethod {get; set;}
  public String sellerID {get; set;}
  
  public mws_Client(String serviceURL, String accessKey, String secret) {
    this.awsAccessKeyId = accessKey;
    this.awsSecretAccessKey = secret;
    this.serviceURL = serviceURL;
    
    signatureMethod = 'HmacSHA256';
  }
  
  public Map<String, Object> defaultParams() {
    Map<String, Object> params = new Map<String, Object>();
    
    params.put('AWSAccessKeyId', awsAccessKeyId);
    if (sellerId != null) {
      params.put('SellerId', sellerId);
    }
    params.put('SignatureMethod', 'HmacSHA256');
    params.put('SignatureVersion', 2);
    params.put('Timestamp', DateTime.now());
    
    return params;
  }
  
  public String signedURL(String resource, String version, Map<String, Object> params) {
    String fullPath = '/' + resource + '/' + version + '/';
    return serviceURL + fullPath + '?' + signedQueryString(params, fullPath);
  }
  
  public String signedQueryString(Map<String, Object> params, String path) {
    // encode
    Map<String, String> result = encodeParams(params); 
    
    // sign
    List<String> keys = new List<String>(result.keySet());
    keys.sort();
    
    List<String> paramsList = new List<String>();
    for (String key : keys) {
      paramsList.add(key + '=' + result.get(key));
    }
    String paramsString = String.join(paramsList, '&');
    
    String host = new URL(serviceURL).getHost();
    String query = 'GET\n' + host + '\n' + path + '\n' + paramsString;
    
    Blob hmac = Crypto.generateMac(signatureMethod, Blob.valueOf(query), Blob.valueOf(awsSecretAccessKey));
    String signature = EncodingUtil.base64Encode(hmac);
    
    return paramsString + '&Signature=' + encodeParam(signature);
  }
  
  private Map<String, String> encodeParams(Map<String, Object> params) {
    Map<String, String> result = new Map<String, String>();
    for (String key : params.keySet()) {
      Object param = params.get(key);
      if (param instanceof List<String>) {
        List<String> l = (List<String>) param;
        for (Integer i = 0; i < l.size(); i++) {
          result.put(key + '.Id.' + (i+1), encodeParam(l[i]));
        }
      } else {
        result.put(key, encodeParam(param));
      }
    }
    return result;
  }
  
  private String encodeParam(Object param) {
    String result = '';
    if (param instanceof DateTime) {
      DateTime dt = (DateTime) param;
      result = dt.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
    } else if (param == null) {
      result = '';
    } else {
      result = String.valueOf(param);
    }
    return EncodingUtil.urlEncode(result, 'utf-8').replace('+', '%20').replace('*', '%2A').replace('%7E', '~');
  }
  
  public Object send(mws_Request request) {
    HttpRequest req = request.toRequest(this);
    if (userAgent != null) {
      req.setHeader('User-Agent', userAgent);
    }
    Http http = new Http();
    HttpResponse res = http.send(req);
    
    return request.handleResponse(res);
  }
}