
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

/**
 * Prints all the co-livings tenants
 */

public class coLivingTenants {
    /**
     * The JDBC driver to be used
     */
    private static final String DRIVER = "org.postgresql.Driver";

    /**
     * The URL of the database to be accessed
     */
    private static final String DATABASE = "jdbc:postgresql://localhost/cldb";

    /**
     * The username for accessing the database
     */
    private static final String USER = "postgres";  // insert username here

    /**
     * The password for accessing the database
     */
    private static final String PASSWORD = "postgres";  // insert password here

    /**
     * List all the co-livings tenants
     * <p>
     * command-line arguments (not used).
     */

    public static void main(String[] args) {

        // the connection to the DBMS
        Connection con = null;

        // the statements to be executed
        PreparedStatement ps0 = null;
        Statement stmt1 = null;
        Statement stmt2 = null;

        // the results of the statement execution
        ResultSet rs0 = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;

        // start time of a statement
        long start;

        // end time of a statement
        long end;

        try {
            // register the JDBC driver
            Class.forName(DRIVER);

            System.out.printf("Driver %s successfully registered.%n", DRIVER);

        } catch (ClassNotFoundException e) {
            System.out.printf(
                    "Driver %s not found: %s.%n", DRIVER, e.getMessage());
            // terminate with a generic error code
            System.exit(-1);
        }

        try {

            // connect to the database
            start = System.currentTimeMillis();
            con = DriverManager.getConnection(DATABASE, USER, PASSWORD);
            end = System.currentTimeMillis();
            System.out.printf(
                    "Connection to database %s successfully established in %,d milliseconds.%n",
                    DATABASE, end - start);

            // first query using PREPAREDSTATEMENT
            String sql0 = "SELECT Q.tenant_name " +
                    "FROM " +
                    "(SELECT * FROM co_living.tenant AS T" +
                    " INNER JOIN (Select * FROM co_living.guest AS G" +
                    " INNER JOIN (select * from co_living.guest_participation  where event_name = ? ) AS P" +
                    " ON G.guest_id = P.guest_id) AS S" +
                    " ON T.tenant_id = S.tenant_id) AS Q;";

            start = System.currentTimeMillis();
            ps0 = con.prepareStatement(sql0);
            ps0.setString(1, "Cooking class");
            end = System.currentTimeMillis();

            System.out.printf("Statement successfully created in %,d milliseconds.%n",end - start);

            start = System.currentTimeMillis();
            rs0 = ps0.executeQuery();
            end = System.currentTimeMillis();

            System.out.printf("Query 1: successfully executed %,d milliseconds.%n", end - start);
            System.out.printf("Query 1 results:%n");

            String tenant_name;

            while (rs0.next()) {
                tenant_name = rs0.getString("tenant_name");

                System.out.printf("%nTenant name: %s%n", tenant_name);
            }
            rs0.close();
            ps0.close();

            // execute the query
            String sql = "Select * FROM co_living.co_living;";
            start = System.currentTimeMillis();
            stmt1 = con.createStatement();
            end = System.currentTimeMillis();

            // create the statement to execute the query
            System.out.printf(
                    "%nStatement successfully created in %,d milliseconds.%n",
                    end - start);

            start = System.currentTimeMillis();
            rs1 = stmt1.executeQuery(sql);
            end = System.currentTimeMillis();

            String address;

            // cycle on the query results and print them
            while (rs1.next()) {
                address = rs1.getString("co_living_address");

                System.out.printf("%nCo-living - %s%n", address);
                System.out.printf("%nNAME\t\tSURNAME\t\tNATIONAL ID%n");

                sql = "SELECT t.tenant_name as Name, t.surname as Surname, t.national_id as ID " +
                        "FROM co_living.tenant as t " +
                        "INNER JOIN co_living.contract as c ON t.tenant_id = c.tenant_ID " +
                        "WHERE c.co_living_address ='" + address + "';";

                stmt2 = con.createStatement();
                rs2 = stmt2.executeQuery(sql);
                String name;
                String surname;
                String id;

                while (rs2.next()) {
                    name = rs2.getString("Name");
                    surname = rs2.getString("Surname");
                    id = rs2.getString("ID");
                    System.out.printf("%-8s\s\s\s\s\s\s\s\s%-8s\s\s\s\s\s\s\s\s%s%n", name, surname, id);
                }
                rs2.close();
                stmt2.close();
            }
            rs1.close();
            stmt1.close();
            con.close();
            end = System.currentTimeMillis();
            System.out.printf("%nData correctly exctracted and visualized in %d milliseconds %n", end - start);

        } catch (SQLException e) {
            System.out.printf("Database access error :%n");
            // cycle in the exception chain
            while (e != null) {
                //e.printStackTrace();
                System.out.printf("- Message : %s%n", e.getMessage());
                System.out.printf("- SQL status code : %s%n", e.getSQLState());
                System.out.printf("- SQL error code : %s%n", e.getErrorCode());
                System.out.printf("%n");
                e = e.getNextException();
            }

        } finally {
            try {
                // close the used resources

                if (!rs0.isClosed() || !rs1.isClosed() || !rs2.isClosed()){
                    start = System.currentTimeMillis();
                    rs0.close();
                    rs1.close();
                    rs2.close();
                    end = System.currentTimeMillis();
                    System.out
                            .printf("Result set successfully closed in finally block”+ ”in %, d milliseconds. % n",
                    end - start);
                }

                if (!ps0.isClosed()) {
                    start = System.currentTimeMillis();
                    ps0.close();
                    end = System.currentTimeMillis();
                    System.out
                            .printf("PREPAREDSTATEMENT successfully closed in finally block”+ ”in %, d milliseconds. % n",
                                    end - start);
                }

                if (!stmt1.isClosed() || !stmt2.isClosed()) {
                    start = System.currentTimeMillis();
                    stmt1.close();
                    stmt2.close();
                    end = System.currentTimeMillis();
                    System.out
                            .printf("Statement successfully closed in finally block”+ ”in %, d milliseconds. % n",
                    end - start);
                }

                if (!con.isClosed()) {
                    start = System.currentTimeMillis();
                    con.close();
                    end = System.currentTimeMillis();
                    System.out
                            .printf("Connection successfully closed in finally block”+ ”in %, d milliseconds. % n",
                                    end - start);
                }
            } catch (SQLException e) {

                System.out.printf("Error while releasing resources in finally block:%n");
                // cycle in the exception chain
                while (e != null) {
                System.out.printf(" - Message: %s % n",e.getMessage());
                System.out.printf(" - SQL status code: %s % n",e.getSQLState());
                System.out.printf(" - SQL error code: %s % n",e.getErrorCode());
                System.out.printf(" % n");
                e = e.getNextException();
                }
            } finally {

                rs0 = null;
                rs1 = null;
                rs2 = null;
                ps0 = null;
                stmt1 = null;
                stmt2 = null;
                con = null;
                System.out.printf("Resources released to the garbage collector.%n");
            }

        }
        System.out.printf("Program end.%n");
    }
}