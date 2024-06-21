package saleson.common.enumeration;

import lombok.Getter;

@Getter
public enum ContextCookieType {

    TOKEN(ContextCookieType.PREFIX + "token", ContextCookieType.BASE_MAX_AGE),
    SALESON_ID(ContextCookieType.PREFIX + "salesonId", ContextCookieType.BASE_MAX_AGE),
    LOGGED_IN(ContextCookieType.PREFIX + "loggedIn", ContextCookieType.BASE_MAX_AGE),
    API(ContextCookieType.PREFIX + "api", ContextCookieType.BASE_MAX_AGE);

    private static final String PREFIX = "saleson.";
    private static final int BASE_MAX_AGE = 60 * 60 * 24;

    private String key;
    private int maxAge;

    ContextCookieType(String key, int maxAge) {
        this.key = key;
        this.maxAge = maxAge;
    }
}
