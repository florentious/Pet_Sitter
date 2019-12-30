package kr.co.acorn.dto;

public class PointDto {
	private String sitterId;
	private String applicId;
	private String regDate;
	
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
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public PointDto(String sitterId, String applicId, String regDate) {
		this.sitterId = sitterId;
		this.applicId = applicId;
		this.regDate = regDate;
	}
	
	
	
	
	
}
