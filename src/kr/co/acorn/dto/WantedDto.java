package kr.co.acorn.dto;

public class WantedDto {
	private int no;
	private String title;
	private String content;
	private String regDate;
	private boolean isEnd;
	private String id;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public boolean isEnd() {
		return isEnd;
	}
	public void setEnd(boolean isEnd) {
		this.isEnd = isEnd;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public WantedDto(int no, String title, String content, String regDate, boolean isEnd, String id) {
		this.no = no;
		this.title = title;
		this.content = content;
		this.regDate = regDate;
		this.isEnd = isEnd;
		this.id = id;
	}
	
	
}
