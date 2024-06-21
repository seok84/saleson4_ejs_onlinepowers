package saleson.common.interceptor;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.util.ObjectUtils;
import org.springframework.util.PathMatcher;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import saleson.common.analytics.firebase.configuration.FirebaseConfig;
import saleson.common.api.infra.SalesonApi;
import saleson.common.async.application.AsyncDataService;
import saleson.common.async.application.dto.AsyncDataRequest;
import saleson.common.configuration.saleson.SalesonMaintenance;
import saleson.common.configuration.saleson.SalesonUrlConfig;
import saleson.common.context.SalesonContext;
import saleson.common.context.SalesonContextHolder;
import saleson.common.enumeration.RedirectPageType;
import saleson.common.handler.FrontEventHandler;
import saleson.common.seo.application.dto.SeoResponse;
import saleson.common.utils.FrontUtils;
import saleson.domains.auth.application.dto.AuthMeResponse;
import saleson.domains.category.application.CategoryService;
import saleson.domains.common.api.dto.AboutUsResponse;
import saleson.domains.common.api.dto.GnbListResponse;
import saleson.domains.mypage.application.MypageService;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Slf4j
public class FrontHandlerInterceptor implements HandlerInterceptor {

    @Autowired
    private SalesonMaintenance salesonMaintenance;

    @Autowired
    private SalesonUrlConfig salesonUrl;

    @Autowired
    private SalesonContextHolder salesonContextHolder;

    @Autowired
    private PathMatcher antPathMatcher;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AsyncDataService asyncDataService;

    @Autowired
    private MypageService mypageService;

    @Autowired
    private FrontEventHandler frontEventHandler;

    @Autowired
    private FirebaseConfig firebaseConfig;

    @Autowired
    private SalesonApi salesonApi;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if (isMaintenanceFLag(request)) {
            response.sendRedirect(RedirectPageType.MAINTENANCE.getUrl());
            return false;
        }

        if (!salesonContextHolder.matchedSalesonId(request)) {
            salesonContextHolder.setSalesonContext(request, salesonContextHolder.getNewSalesonContext(request));
        }

        if (isLoggedInPage(request)) {

            response.sendRedirect(RedirectPageType.LOGIN.getUrl() + "?target=" + request.getRequestURI());
            return false;
        }

        RedirectPageType redirectPageType = getRedirectPageTypeByUserStatus(request);
        if (!ObjectUtils.isEmpty(redirectPageType)) {
            response.sendRedirect(redirectPageType.getUrl());
            return false;
        }

        return true;
    }

    public void postHandle(
            HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {

        String requestUri = FrontUtils.getRequestUri(request);

        if (isMaintenanceFLag(request) ||
                (!isMaintenanceFLag(request) && RedirectPageType.MAINTENANCE.getUrl().equals(requestUri))) {
            modelAndView = null;
        }

        // @ResponseBody 사용 시 modelAndView 가 넘어오지 않음.
        if (modelAndView != null) {


            SalesonContext salesonContext = salesonContextHolder.getSalesonContext(request);
            salesonContextHolder.setSalesonContext(request, salesonContext);

            salesonContext.setRequestUri(requestUri);

            modelAndView.addObject("salesonUrl", salesonUrl);
            modelAndView.addObject("salesonContext", salesonContext);


            List<Cookie> cookies = salesonContextHolder.getContextCookies(salesonContext);

            if (!ObjectUtils.isEmpty(cookies)) {
                cookies.forEach(cookie -> {
                    response.addCookie(cookie);
                });
            }

            response.setHeader("Cache-Control", "no-cache, no-store");
            response.setHeader("Pragma", "no-cache");

            // Header start

            boolean isAjax = "XMLHttpRequest".equals(request.getHeader("x-requested-with"));

            if (!isAjax) {
                // 카테고리 정보
                categoryService.setModelForFrontCategories(modelAndView, request);

                //  Firebase 설정
                modelAndView.addObject("firebaseConfig", firebaseConfig);

                /* Async 데이터
                    1. Seo
                 */

                try {
                    Map<String, Object> seoParams = new LinkedHashMap<>();
                    seoParams.put("u", requestUri);

                    asyncDataService.setModelAndViewBy(request, modelAndView,
                            new AsyncDataRequest<>("seo", "/api/seo", HttpMethod.GET, SeoResponse.class, seoParams)
                    );

                } catch (Exception e) {
                    log.error("FrontHandlerInterceptor asyncData error {}", e.getMessage(), e);
                }

                // Display Top Banner
                boolean displayTopBanner = !salesonContext.isMobileFlag()
                        && ObjectUtils.isEmpty(FrontUtils.getCookie(request, "TOP_BANNER_COOKIE"));
                modelAndView.addObject("displayTopBanner", displayTopBanner);

                // mypage header
                if (requestUri.startsWith("/mypage")) {
                    // 비회원이 아닌 경우만 마이페이지 헤더 정보가 존재
                    if (!"ROLE_GUEST".equals(salesonContext.getUser().getLoginType())){
                        mypageService.mypageHeader(modelAndView, salesonContextHolder.getSalesonContext(request));
                    }
                }

                String latelyItem = frontEventHandler.getLatelyItemIds(request);
                int latelyItemCount = 0;

                try {
                    if (!ObjectUtils.isEmpty(latelyItem)) {
                        latelyItemCount = StringUtils.delimitedListToStringArray(latelyItem, ",").length;
                    }
                } catch (Exception e) {
                    log.error("FrontHandlerInterceptor recentItemCount error {}", e.getMessage(), e);
                }
                modelAndView.addObject("latelyItemCount", latelyItemCount);
                modelAndView.addObject("latelySearchList", frontEventHandler.getLatelySearchList(request));
            }

        }

        // Header end
    }

    /**
     * 로그인이 필요한 페이지 체크
     * W
     *
     * @param request
     */
    private boolean isLoggedInPage(HttpServletRequest request) {

        boolean loggedIn = false;

        List<String> loggedInPaths = List.of(
                "/mypage",
                "/mypage/**",
                "/customer/inquiry"
        );

        List<String> nonMemberPaths = List.of(
            "/mypage/info/**"

        );


        String requestUri = request.getRequestURI();
        SalesonContext salesonContext = salesonContextHolder.getSalesonContext(request);

        if (!ObjectUtils.isEmpty(salesonContext)) {
            loggedIn = salesonContext.isHasToken();
            if (!ObjectUtils.isEmpty(salesonContext.getUser()) && salesonContext.isGuestLogin()) {
                for (String pattern : nonMemberPaths) {
                    if (!antPathMatcher.match(pattern, requestUri)) {
                        loggedIn = false;
                    }
                }
            }
        }


        for (String pattern : loggedInPaths) {
            if (!loggedIn && antPathMatcher.match(pattern, requestUri)) {
                return true;
            }
        }
        return false;

    }

    private RedirectPageType getRedirectPageTypeByUserStatus(HttpServletRequest request) {

        String requestUri = FrontUtils.getRequestUri(request);
        SalesonContext salesonContext = salesonContextHolder.getSalesonContext(request);



        List<String> exceptionRoutePaths = List.of(
                RedirectPageType.TEMP_PASSWORD.getUrl(),
                RedirectPageType.EXPIRED_PASSWORD.getUrl(),
                RedirectPageType.SLEEP_USER.getUrl(),
                "/user/modify",
                "/user/my-info-edit",
                "/user/my-info-edit-business",
                "/user/my-info-edit-corporate",
                "/user/certification-success",
                "/user/certification-fail",
                "/auth/logout",
                "/user/login",
                "/auth/refresh",
                "/footer"
        );

        // 로그인 전
        if (!salesonContext.isHasToken()) {
            return null;
        }

        // 로그인후
        AuthMeResponse user = salesonContext.getUser();

        if (ObjectUtils.isEmpty(user)) {
            return RedirectPageType.LOGIN;
        }

        if (exceptionRoutePaths.contains(requestUri)) {
            return null;
        }

        if (user.isSleepUserFlag()) {
            return RedirectPageType.SLEEP_USER;
        }

        if (user.isTempPasswordFlag()) {
            return RedirectPageType.TEMP_PASSWORD;
        }

        if (user.isExpiredPasswordFlag()) {
            return RedirectPageType.EXPIRED_PASSWORD;
        }

        if (user.isCertificationFlag()) {

        }

        return null;
    }

    private boolean isMaintenanceFLag(HttpServletRequest request) {

        String requestUri = FrontUtils.getRequestUri(request);

        if (RedirectPageType.MAINTENANCE.getUrl().equals(requestUri)) {
            return false;
        }

        return salesonMaintenance.isMaintenance();
    }
}
