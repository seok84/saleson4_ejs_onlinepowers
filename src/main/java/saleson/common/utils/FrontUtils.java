package saleson.common.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.util.UrlPathHelper;
import saleson.common.enumeration.DeviceType;

import java.util.Arrays;
import java.util.regex.Pattern;

public class FrontUtils {

    private static UrlPathHelper getUrlPathHelper() {
        UrlPathHelper urlPathHelper = new UrlPathHelper();
        urlPathHelper.setDefaultEncoding("UTF-8");
        return urlPathHelper;
    }

    public static String getRequestUri(HttpServletRequest request) {

        UrlPathHelper urlPathHelper = getUrlPathHelper();

        try {
            return stripXSS(urlPathHelper.getOriginatingRequestUri(request));
        } catch (Exception e) {
            return stripXSS(request.getRequestURI());
        }
    }

    public static String getQueryString(HttpServletRequest request) {
        UrlPathHelper urlPathHelper = getUrlPathHelper();
        return stripXSS(urlPathHelper.getOriginatingQueryString(request));
    }

    public static String stripXSS(String value) {
        if (value != null) {
            value = value.replaceAll("", "");
            Pattern scriptPattern = Pattern.compile("<script>(.*?)</script>", 2);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\'(.*?)\\'", 42);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", 42);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("</script>", 2);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("<script(.*?)>", 42);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("eval\\((.*?)\\)", 42);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("expression\\((.*?)\\)", 42);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("javascript:", 2);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("vbscript:", 2);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("onload(.*?)=", 42);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("onmouseover(.*?)=", 42);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("onerror(.*?)=", 42);
            value = scriptPattern.matcher(value).replaceAll("");
            value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
            value = value.replaceAll("'", "&#39;");
            value = value.replaceAll("<(/)?([a-zA-Z1-9]*)(\\s[a-zA-Z1-9]*=[^>]*)?(\\s)*(/)?>", "");
            value = value.replaceAll("<", "&lt;");
            value = value.replaceAll(">", "&gt;");
            value = value.replaceAll("\"", "&quot;");
            value = value.replaceAll("\\'", "&#39;");
        }

        return value;
    }

    public static Cookie getCookie(HttpServletRequest request, String name) {

        Cookie[] cookies = request.getCookies();

        if (!ObjectUtils.isEmpty(name) && !ObjectUtils.isEmpty(cookies)) {
            return Arrays.stream(cookies)
                    .filter(cookie -> name.equals(cookie.getName())).findFirst()
                    .orElse(null);
        }

        return null;
    }

    public static DeviceType getDeviceType(HttpServletRequest request) {

        String userAgent = request.getHeader("User-Agent");

        if (!ObjectUtils.isEmpty(userAgent)) {
            if (userAgent.contains("SALESON_APPLICATION_IOS")) {
                return DeviceType.IOS;
            }

            if (userAgent.contains("SALESON_APPLICATION_ANDROID")) {
                return DeviceType.ANDROID;
            }

            if (userAgent.contains("Mobi")) {
                return DeviceType.MOBILE;
            }
        }

        return DeviceType.PC;
    }

    public static String getAppVersion(HttpServletRequest request) {

        try {
            String userAgent = request.getHeader("User-Agent");
            if (!ObjectUtils.isEmpty(userAgent)) {
                String[] arrayUserAgent = StringUtils.delimitedListToStringArray(userAgent, " ");

                if (!ObjectUtils.isEmpty(arrayUserAgent)) {
                    for (String s : arrayUserAgent) {
                        if (s.startsWith("appver=")) {
                            String[] appver = StringUtils.delimitedListToStringArray(s.trim(),"=");
                            if (!ObjectUtils.isEmpty(appver)) {
                                return appver[1];
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {

        }

        return "";
    }

    public static String padZero(int value) {

        if (value < 10) {
            return "0"+value;
        }

        return String.valueOf(value);
    }

    public static String nl2br(String value) {

        if (ObjectUtils.isEmpty(value)) {
            return "";
        }

        return value.replaceAll("\n", "<br />");
    }
}
