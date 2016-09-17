@isTest
public class mws_HttpCalloutMock implements HttpCalloutMock {
  public HttpResponse response;
  
  public HttpResponse respond(HttpRequest req) {
    return response;
  }
}