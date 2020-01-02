package kr.co.acorn.dto;

public class BookDto {
	private int no;
	private String sitterId;
	private String applicId;
	private String content;
	private String regDate;
	private String bookStart;
	private String bookEnd;
	private boolean isConfirm;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getSitterId() {
		return sitterId;
	}
	public void setSitterId(String sitterId) {
		this.sitterId = sitterId;
	}
	public String getApplicId() {
		return applicId;
	}
	public void setApplicId(String applicId) {
		this.applicId = applicId;
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
	public String getBookStart() {
		return bookStart;
	}
	public void setBookStart(String bookStart) {
		this.bookStart = bookStart;
	}
	public String getBookEnd() {
		return bookEnd;
	}
	public void setBookEnd(String bookEnd) {
		this.bookEnd = bookEnd;
	}
	public boolean isConfirm() {
		return isConfirm;
	}
	public void setConfirm(boolean isConfirm) {
		this.isConfirm = isConfirm;
	}
	
	public BookDto(int no, String sitterId, String applicId, String content, String regDate, String bookStart,
			String bookEnd, boolean isConfirm) {
		super();
		this.no = no;
		this.sitterId = sitterId;
		this.applicId = applicId;
		this.content = content;
		this.regDate = regDate;
		this.bookStart = bookStart;
		this.bookEnd = bookEnd;
		this.isConfirm = isConfirm;
	}
	
	
	
}
