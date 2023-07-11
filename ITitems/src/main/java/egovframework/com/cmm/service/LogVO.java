package egovframework.com.cmm.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class LogVO implements Serializable {

	/** 사용자 */
	private String conectId;

	/** URI */
	private String conectUri;

	/** 브라우저 */
	private String broswser;
	
	/** os */
	private String os;
	
	/** 기기 */
	private String model;
	
	/** 브랜드 */
	private String brand;
	
	/** 헤더 */
	private String header;

	/** 날짜 */
	private String creatDt;

	public String getConectId() {
		return conectId;
	}

	public void setConectId(String conectId) {
		this.conectId = conectId;
	}

	public String getConectUri() {
		return conectUri;
	}

	public void setConectUri(String conectUri) {
		this.conectUri = conectUri;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getBroswser() {
		return broswser;
	}

	public void setBroswser(String broswser) {
		this.broswser = broswser;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getCreatDt() {
		return creatDt;
	}

	public void setCreatDt(String creatDt) {
		this.creatDt = creatDt;
	}

	public String getOs() {
		return os;
	}

	public void setOs(String os) {
		this.os = os;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}
	
	
}
