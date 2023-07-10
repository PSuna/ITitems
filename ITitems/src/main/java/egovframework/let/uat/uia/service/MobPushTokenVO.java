package egovframework.let.uat.uia.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class MobPushTokenVO implements Serializable {
	//
	private String uniqId; // 사용자 고유 아이디
	private String pushToken; // 사용자 기기 푸시 토큰 정보
	private String tokenRegistDate; // 토큰 등록일
	private String tokenDeleteDate;// 토큰 삭제일
	private String tokenState;// 토큰 사용 상태(Y:사용중 / Q:확인필요 / N:삭제완료)

	// getter setter
	public String getUniqId() {
		return uniqId;
	}

	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}

	public String getPushToken() {
		return pushToken;
	}

	public void setPushToken(String pushToken) {
		this.pushToken = pushToken;
	}

	public String getTokenRegistDate() {
		return tokenRegistDate;
	}

	public void setTokenRegistDate(String tokenRegistDate) {
		this.tokenRegistDate = tokenRegistDate;
	}

	public String getTokenDeleteDate() {
		return tokenDeleteDate;
	}

	public void setTokenDeleteDate(String tokenDeleteDate) {
		this.tokenDeleteDate = tokenDeleteDate;
	}

	public String getTokenState() {
		return tokenState;
	}

	public void setTokenState(String tokenState) {
		this.tokenState = tokenState;
	}

	// toString
	@Override
	public String toString() {
		return "mobPushTokenVO [uniqId=" + uniqId + ", pushToken=" + pushToken + ", tokenRegistDate=" + tokenRegistDate
				+ ", tokenDeleteDate=" + tokenDeleteDate + ", tokenState=" + tokenState + "]";
	}

}
