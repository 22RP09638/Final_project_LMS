package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class addUser_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>Register User</title>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            display: flex;\n");
      out.write("            justify-content: center;\n");
      out.write("            align-items: center;\n");
      out.write("            height: 100vh;\n");
      out.write("            margin: 0;\n");
      out.write("            background-color: #f5f5f5;\n");
      out.write("            font-family: Arial, sans-serif;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .seye {\n");
      out.write("            width: 90%;\n");
      out.write("            max-width: 600px;\n");
      out.write("            padding: 0;\n");
      out.write("            background-color: white;\n");
      out.write("            border: 1px solid #ddd;\n");
      out.write("            border-radius: 5px;\n");
      out.write("            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\n");
      out.write("            margin-top: 20px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        h1 {\n");
      out.write("            margin: 0;\n");
      out.write("            color: #fff;\n");
      out.write("            background-color: #294c8e;\n");
      out.write("            padding: 10px;\n");
      out.write("            border-radius: 5px 5px 0 0;\n");
      out.write("            text-align: center;\n");
      out.write("            margin-top: -10px;\n");
      out.write("            width: 100%;\n");
      out.write("            margin-left: -10px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        form {\n");
      out.write("            display: flex;\n");
      out.write("            flex-direction: column;\n");
      out.write("            padding: 10px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        label {\n");
      out.write("            margin-bottom: 3px;\n");
      out.write("            color: #333;\n");
      out.write("            font-size: 14px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        input, select {\n");
      out.write("            margin-bottom: 10px;\n");
      out.write("            padding: 8px;\n");
      out.write("            border: 1px solid #ddd;\n");
      out.write("            border-radius: 5px;\n");
      out.write("            font-size: 14px;\n");
      out.write("            width: 100%;\n");
      out.write("            box-sizing: border-box;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        button {\n");
      out.write("            padding: 10px;\n");
      out.write("            border: none;\n");
      out.write("            border-radius: 5px;\n");
      out.write("            background-color: #294c8e;\n");
      out.write("            color: #fff;\n");
      out.write("            font-size: 14px;\n");
      out.write("            cursor: pointer;\n");
      out.write("            transition: background-color 0.3s;\n");
      out.write("            width: 100%;\n");
      out.write("            max-width: 200px;\n");
      out.write("            align-self: center;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        button:hover {\n");
      out.write("            background-color: #2d4373;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        p {\n");
      out.write("            margin-top: 10px;\n");
      out.write("            text-align: center;\n");
      out.write("            font-size: 14px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        a {\n");
      out.write("            color: #3b5998;\n");
      out.write("            text-decoration: none;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        a:hover {\n");
      out.write("            text-decoration: underline;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .error-message {\n");
      out.write("            color: red;\n");
      out.write("            text-align: center;\n");
      out.write("            margin-top: 10px;\n");
      out.write("            font-size: 14px;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("    <script>\n");
      out.write("        function validateForm() {\n");
      out.write("            var password = document.getElementById(\"password\").value;\n");
      out.write("            var confirmPassword = document.getElementById(\"confirmPassword\").value;\n");
      out.write("            if (password !== confirmPassword) {\n");
      out.write("                alert(\"Passwords do not match.\");\n");
      out.write("                return false;\n");
      out.write("            }\n");
      out.write("            return true;\n");
      out.write("        }\n");
      out.write("    </script>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <div class=\"seye\">\n");
      out.write("        <form method=\"post\" action=\"addUser\" onsubmit=\"return validateForm()\">\n");
      out.write("            <h1>CREATE ACCOUNT</h1>\n");
      out.write("            <label for=\"username\">Username:</label>\n");
      out.write("            <input type=\"text\" id=\"username\" name=\"username\" required>\n");
      out.write("            <label for=\"email\">Email:</label>\n");
      out.write("            <input type=\"email\" id=\"email\" name=\"email\" required>\n");
      out.write("            <label for=\"role\">Role:</label>\n");
      out.write("            <select id=\"role\" name=\"role\" required>\n");
      out.write("                <option value=\"Student\">Student</option>\n");
      out.write("                <option value=\"Staff\">Staff</option>\n");
      out.write("                <option value=\"External\">External</option>\n");
      out.write("            </select>\n");
      out.write("            <label for=\"password\">Password:</label>\n");
      out.write("            <input type=\"password\" id=\"password\" name=\"password\" required>\n");
      out.write("            <label for=\"confirmPassword\">Confirm Password:</label>\n");
      out.write("            <input type=\"password\" id=\"confirmPassword\" name=\"confirmPassword\" required>\n");
      out.write("            <button type=\"submit\">SIGNUP</button>\n");
      out.write("            <p>If you have an account, click here to <a href=\"login.jsp\">LOGIN</a></p>\n");
      out.write("        </form>\n");
      out.write("        ");
 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        
      out.write("\n");
      out.write("            <p class=\"error-message\">");
      out.print( errorMessage );
      out.write("</p>\n");
      out.write("        ");
 } 
      out.write("\n");
      out.write("    </div>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
