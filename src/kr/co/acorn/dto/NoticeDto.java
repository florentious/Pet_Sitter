package kr.co.acorn.dto;

public class NoticeDto {
	private int no;
	private String title;
	private String id;
	private String regDate;
	private String contents;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	
	public NoticeDto(int no, String title, String id, String regDate, String contents) {
		this.no = no;
		this.title = title;
		this.id = id;
		this.regDate = regDate;
		this.contents = contents;
	}
	
	
	
	
}
