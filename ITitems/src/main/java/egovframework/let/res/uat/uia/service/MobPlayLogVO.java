package egovframework.let.res.uat.uia.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class MobPlayLogVO implements Serializable {
	//
	private String playLogId;
	private String playId;
	private String os;
	private String model;
	private String brand;
	private String playDate;
	private String lastPlayDate;
	private String uniqId;
	private String loginState;
	private String logoutDate;
	
	
	public String getPlayLogId() {
		return playLogId;
	}
	public void setPlayLogId(String playLogId) {
		this.playLogId = playLogId;
	}
	public String getPlayId() {
		return playId;
	}
	public void setPlayId(String playId) {
		this.playId = playId;
	}
	public String getOs() {
		return os;
	}
	public void setOs(String os) {
		this.os = os;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getPlayDate() {
		return playDate;
	}
	public void setPlayDate(String playDate) {
		this.playDate = playDate;
	}
	public String getLastPlayDate() {
		return lastPlayDate;
	}
	public void setLastPlayDate(String lastPlayDate) {
		this.lastPlayDate = lastPlayDate;
	}
	public String getUniqId() {
		return uniqId;
	}
	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}
	public String getLoginState() {
		return loginState;
	}
	public void setLoginState(String loginState) {
		this.loginState = loginState;
	}
	public String getLogoutDate() {
		return logoutDate;
	}
	public void setLogoutDate(String logoutDate) {
		this.logoutDate = logoutDate;
	}
	@Override
	public String toString() {
		return "MobPlayLogVO [playLogId=" + playLogId + ", playId=" + playId + ", os=" + os + ", model=" + model + ", brand="
				+ brand + ", playDate=" + playDate + ", lastPlayDate=" + lastPlayDate + ", uniqId=" + uniqId
				+ ", loginState=" + loginState + ", logoutDate=" + logoutDate + "]";
	}

	

	
}
