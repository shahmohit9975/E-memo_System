package bean;

public class LoginBean {
	private String password;
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		System.out.println("id : "+id);
		this.id = id;
	}
	

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		System.out.println("password : "+password);
		this.password = password;
	}

}