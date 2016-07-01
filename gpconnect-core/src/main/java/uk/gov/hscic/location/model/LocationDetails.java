package uk.gov.hscic.location.model;

import java.io.Serializable;

public class LocationDetails implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id;
	private String name;
	private String siteOdsCode;
	private String siteOdsCodeName;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSiteOdsCode() {
		return siteOdsCode;
	}

	public void setSiteOdsCode(String siteOdsCode) {
		this.siteOdsCode = siteOdsCode;
	}

	public String getSiteOdsCodeName() {
		return siteOdsCodeName;
	}

	public void setSiteOdsCodeName(String siteOdsCodeName) {
		this.siteOdsCodeName = siteOdsCodeName;
	}

}