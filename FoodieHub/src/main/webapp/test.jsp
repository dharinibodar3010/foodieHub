<%@ page import="java.io.*, java.util.*" %>
<%
    String result = "";
    try {
        File logDir = new File("C:/Users/DELL/spring-workspace/FoodieHub");
        File[] files = logDir.listFiles(new FilenameFilter() {
            public boolean accept(File dir, String name) {
                return name.endsWith(".log");
            }
        });
        
        if (files != null && files.length > 0) {
            for (File f : files) {
                result += "File: " + f.getName() + "\n";
                RandomAccessFile raf = new RandomAccessFile(f, "r");
                long length = raf.length();
                long start = length - 2000;
                if (start < 0) start = 0;
                raf.seek(start);
                byte[] bytes = new byte[(int)(length - start)];
                raf.readFully(bytes);
                result += new String(bytes) + "\n\n";
                raf.close();
            }
        } else {
            result = "No logs found in project dir.";
        }
    } catch(Exception e) {
        result = "Error: " + e.getMessage();
    }
%>
<pre><%= result %></pre>
