package bean;

import java.sql.*;

public class LoginDao_for_police {

	public static boolean validate(LoginBean bean) {
		boolean status = false;
		try {
			Connection con = ConnectionProvider.getCon();
			PreparedStatement ps = con
					.prepareStatement("select * from ememo.officers where o_type='p' and o_id=? and o_pass=?");

			ps.setInt(1, bean.getId());
			ps.setString(2, bean.getPassword());

			ResultSet rs = ps.executeQuery();
			status = rs.next();

		} catch (Exception e) {
		}

		return status;

	}
}