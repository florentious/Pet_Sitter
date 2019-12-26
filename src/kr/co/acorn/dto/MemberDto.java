package kr.co.acorn.dto;

public class MemberDto {
	private String id;
	private String pwd;
	private String name;
	private String loc;
	private String phone;
	private String curPet;
	private String imgPath;
	private String comment;
	private byte type;
	
	private String regDate;
	private int point;
	private int pointCount;
	

	//getter and setter
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCurPet() {
		return curPet;
	}
	public void setCurPet(String curPet) {
		this.curPet = curPet;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public byte getType() {
		return type;
	}
	public void setType(byte type) {
		this.type = type;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getPointCount() {
		return pointCount;
	}
	public void setPointCount(int pointCount) {
		this.pointCount = pointCount;
	}

	// constructor
	public MemberDto(String id, String pwd, String name, String loc, String phone, String curPet, String imgPath,
			String comment, byte type, String regDate, int point, int pointCount) {
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.loc = loc;
		this.phone = phone;
		this.curPet = curPet;
		this.imgPath = imgPath;
		this.comment = comment;
		this.type = type;
		this.regDate = regDate;
		this.point = point;
		this.pointCount = pointCount;
	}
	public MemberDto(String id, String pwd) {
		
		this(id,pwd,null,null,null,null,null,null,(byte) 0,null,0,0);
	}
	
	
	
	
	
	

}
