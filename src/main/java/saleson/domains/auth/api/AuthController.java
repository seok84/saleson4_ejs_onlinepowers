package saleson.domains.auth.api;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import saleson.common.context.SalesonContext;
import saleson.common.context.SalesonContextHolder;
import saleson.common.view.JsonView;
import saleson.domains.auth.application.AuthService;
import saleson.domains.auth.application.dto.AnalyticsUser;
import saleson.domains.auth.application.dto.AuthMeRequest;
import saleson.domains.auth.application.dto.AuthMeResponse;

import java.io.IOException;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
@Slf4j
public class AuthController {

    private final SalesonContextHolder salesonContextHolder;

    private final AuthService authService;

    @ResponseBody
    @PostMapping("/fetch")
    public JsonView fetch(HttpServletRequest request, AuthMeRequest authMeRequest) throws IOException {

        try {

            SalesonContext salesonContext = salesonContextHolder.getSalesonContext(request);

            if (!salesonContext.getSalesonId().equals(authMeRequest.getSalesonId())) {
                throw new IllegalArgumentException("sessionId not matched");
            }

            String token = authMeRequest.getToken();

            AuthMeResponse authMe = authService.getAuthMe(request, token);

            salesonContext.setToken(token);
            salesonContext.setUser(authMe);

            // 해당 토큰으로 회원 정보 조회후 세션에 다시 추가
            salesonContextHolder.setSalesonContext(request, salesonContext);

            if(!"ROLE_GUEST".equals(authMe.getLoginType())) {
                return JsonView.builder()
                    .data(
                        AnalyticsUser.builder()
                            .userId(authMe.getUserId())
                            .build()
                    )
                    .successFlag(true)
                    .build();
            } else {
                return  JsonView.builder()
                    .successFlag(true)
                    .build();
            }

        } catch (Exception e) {
            salesonContextHolder.removeSalesonContext(request);
            log.error("Auth fetch error {}", e.getMessage(), e);
            return JsonView.builder()
                    .successFlag(false)
                    .build();
        }
    }

    @ResponseBody
    @PostMapping("/refresh")
    public JsonView refresh(HttpServletRequest request) throws IOException {

        try {
            authService.refreshAuthMe(request);

            return JsonView.builder()
                    .successFlag(true)
                    .build();

        } catch (Exception e) {
            salesonContextHolder.removeSalesonContext(request);
            log.error("Auth fetch error {}", e.getMessage(), e);
            return JsonView.builder()
                    .successFlag(false)
                    .build();
        }
    }


    @GetMapping("/logout")
    public void logout(HttpServletRequest request,
                       HttpServletResponse response,
                       @RequestParam(name = "redirect", defaultValue = "/") String redirect) throws IOException {

        salesonContextHolder.removeSalesonContext(request);
        request.getSession().invalidate();
        request.getSession(true);
        response.sendRedirect(redirect);
    }
}
