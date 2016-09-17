public class mws_DomUtil {
  public static Dom.XmlNode child(Dom.XmlNode node, String name) {
    return node.getChildElement(name, 'http://mws.amazonaws.com/doc/2009-01-01/');
  }
  
  public static List<Dom.XmlNode> children(Dom.XmlNode node, String name) {
    List<Dom.XmlNode> ns = node.getChildElements();
    for (Integer i = ns.size() - 1; i >= 0; i--) {
      Dom.XmlNode n = ns.get(i);
      if (n.getName().equals(name) == false) {
        ns.remove(i);
      }
    }
    return ns;
  }
  
  public static String string(Dom.XmlNode node, String name) {
    Dom.XmlNode n = child(node, name);
    return n != null ? n.getText() : null;
  }
  
  public static DateTime datetime(Dom.XmlNode node, String name) {
    String v = string(node, name);
    return v != null ? (DateTime) JSON.deserialize('"' + v + '"', DateTime.class) : null;
  }
  
  public static Boolean boolean(Dom.XmlNode node, String name) {
    String v = string(node, name);
    return v != null ? (Boolean) JSON.deserialize(v, Boolean.class) : null;
  }

  public static mws_ReportType reportType(Dom.XmlNode node, String name) {
    name = string(node, name);
    for (mws_ReportType reportType : mws_ReportType.values()) {
      if (name.equals('_' + reportType.name() + '_')) {
        return reportType;
      }
    }
    return null;
  }
}