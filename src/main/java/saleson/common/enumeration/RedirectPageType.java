package saleson.common.enumeration;

import lombok.Getter;

@Getter
public enum RedirectPageType {

    INDEX("/",""),
    LOGIN("/user/login",""),
    SLEEP_USER("/user/sleep-user","휴면 전환된 계정입니다."),
    EXPIRED_PASSWORD("/user/expired-password","비밀번호를 변경해주세요."),
    TEMP_PASSWORD("/user/change-password","패스워드 기간이 만료 되었습니다."),
    MAINTENANCE("/maintenance",""),
    ;

    private String url;
    private String message;

    RedirectPageType(String url, String message) {
        this.url = url;
        this.message = message;
    }
}
