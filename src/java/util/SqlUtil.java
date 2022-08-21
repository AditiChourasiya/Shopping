package util;

import java.sql.*;

public class SqlUtil 
{
     public static Connection conn;
     public static Statement stmt;
     
     
     public static Connection connectDB() throws ClassNotFoundException,SQLException
     {
          Class.forName("oracle.jdbc.OracleDriver");
          conn = DriverManager.getConnection("jdbc:oracle:thin:@//AdarshChourasia:1521/xe","ecommerce","ecommerce");
         stmt=conn.createStatement();
         return conn;
     }
     
     public static int insert(String query) throws SQLException
     {
         int result = -1;
         
         if(query != "")
         {
            result = stmt.executeUpdate(query);
         }
         
         return result;
     }
     
     public static int update(String query) throws SQLException
     {
         int result = -1;
         
         if(query != "")
         {
            result = stmt.executeUpdate(query);
         }
         
         return result;
     }
     
     public static ResultSet read(String query) throws SQLException
     {
         ResultSet rs = null;
         
         if(query != "")
         {
            rs = stmt.executeQuery(query);
         }
         
         return rs;
     }
     
     public static int delete(String query) throws SQLException
     {
         int result = -1;
         
         if(query != "")
         {
            result = stmt.executeUpdate(query);
         }
         
         return result;
     }
     
     public static void close() throws SQLException
     {
         if(conn != null)
         {
             conn.close();
         }
         
         if(stmt != null)
         {
             stmt.close();
         }
     } 
}
