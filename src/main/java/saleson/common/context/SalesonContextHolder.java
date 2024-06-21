package saleson.common.context;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import saleson.common.configuration.saleson.SalesonUrlConfig;
import saleson.common.enumeration.ContextCookieType;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Slf4j
@RequiredArgsConstructor
@Component
public class SalesonContextHolder {

    private final SalesonUrlConfig salesonUrlConfig;

    /**
     * 세션 확인
     * @param request
     * @return
     */
    private HttpSession getHttpSession(HttpServletRequest request) {

        if (ObjectUtils.isEmpty(request)) {
            return null;
        }

        return request.getSession();
    }

    /**
     * 신규 Context 생성
     * @return
     */
    public SalesonContext getNewSalesonContext(HttpServletRequest request) {
        SalesonContext salesonContext = new SalesonContext(request);
        salesonContext.setSalesonId(UUID.randomUUID().toString());
        return salesonContext;
    }

    /**
     * 세션에서 Context 조회
     * @param request
     * @return
     */
    public SalesonContext getSalesonContext(HttpServletRequest request) {

        HttpSession session = getHttpSession(request);
        SalesonContext context = null;
        if (!ObjectUtils.isEmpty(session)) {
            context = (SalesonContext) request.getSession().getAttribute(SalesonContext.REQUEST_NAME);
        }

        if (ObjectUtils.isEmpty(context)) {
            return getNewSalesonContext(request);
        }

        context.setDeviceInfo(request);

        return context;
    }

    /**
     * 세션에 Context 저장
     * @param request
     * @param context
     */
    public void setSalesonContext(HttpServletRequest request, SalesonContext context) {

        HttpSession session = getHttpSession(request);

        session.setAttribute(SalesonContext.REQUEST_NAME, context);
    }

    /**
     * 세션에서 Context 제거
     * @param request
     */
    public void removeSalesonContext(HttpServletRequest request) {

        HttpSession session = getHttpSession(request);

        session.removeAttribute(SalesonContext.REQUEST_NAME);
    }

    /**
     * Context 용  쿠키생성
     */
    public List<Cookie> getContextCookies(SalesonContext salesonContext) {


        List<Cookie> cookies = new ArrayList<>();

        cookies.add(getCookie(ContextCookieType.TOKEN, salesonContext.getToken()));
        cookies.add(getCookie(ContextCookieType.SALESON_ID, salesonContext.getSalesonId()));
        cookies.add(getCookie(ContextCookieType.LOGGED_IN, String.valueOf(salesonContext.isHasToken())));
        cookies.add(getCookie(ContextCookieType.API, salesonUrlConfig.getApi()));

        return cookies;
    }

    private Cookie getCookie(ContextCookieType type, String value) {

        if (ObjectUtils.isEmpty(value)) {
            value = "";
        }

        Cookie cookie = new Cookie(type.getKey(), value);

        cookie.setPath("/");
        cookie.setMaxAge(type.getMaxAge());
        cookie.setAttribute("samesite","Lax");

        return cookie;
    }

    /**
     * 쿠키에 있는 salesonId 와 다를경우 확인
     * 쿠키가 없을경우 는 회피처리
     * @param request
     * @return
     */
    public boolean matchedSalesonId(HttpServletRequest request) {

        SalesonContext salesonContext = this.getSalesonContext(request);
        Cookie[] cookies = request.getCookies();
        String name = ContextCookieType.SALESON_ID.getKey();
        if (!ObjectUtils.isEmpty(cookies)) {
            Cookie cookie = Arrays.stream(cookies)
                    .filter(c -> name.equals(c.getName()))
                    .findFirst().orElse(null);

            if (!ObjectUtils.isEmpty(cookie)) {
                return salesonContext.getSalesonId().equals(cookie.getValue());
            }
        }

        return true;
    }

}
