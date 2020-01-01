package kr.co.acorn.dto;

public class CommentDto {
	private int no;
	private int wantedNo;
	private String id;
	private String comment;
	private String regDate;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getWantedNo() {
		return wantedNo;
	}
	public void setWantedNo(int wantedNo) {
		this.wantedNo = wantedNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public CommentDto(int no, int wantedNo, String id, String comment, String regDate) {
		this.no = no;
		this.wantedNo = wantedNo;
		this.id = id;
		this.comment = comment;
		this.regDate = regDate;
	}
	
	
	
	
	
}
