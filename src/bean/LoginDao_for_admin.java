package bean;

import java.sql.*;

public class LoginDao_for_admin {

	public static boolean validate(LoginBean bean) {
		boolean status = false;
		try {
			Connection con = ConnectionProvider.getCon();
			PreparedStatement ps = con.prepareStatement("select * from ememo.admin where a_id=? and a_pass=?");

			ps.setInt(1, bean.getId());
			ps.setString(2, bean.getPassword());

			ResultSet rs = ps.executeQuery();
			status = rs.next();

		} catch (Exception e) {
		}

		return status;

	}
}