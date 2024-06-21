package saleson.domains.auth.application;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import saleson.common.api.infra.SalesonApi;
import saleson.common.context.SalesonContext;
import saleson.common.context.SalesonContextHolder;
import saleson.domains.auth.application.dto.AuthMeResponse;

@Service
@RequiredArgsConstructor
@Slf4j
public class AuthService {

    private final SalesonContextHolder salesonContextHolder;
    private final SalesonApi salesonApi;

    /**
     * 세션의 인증정보 새로고침
     * @param request
     * @throws Exception
     */
    public void refreshAuthMe(HttpServletRequest request) throws Exception {
        SalesonContext salesonContext = salesonContextHolder.getSalesonContext(request);

        String token = salesonContext.getToken();
        AuthMeResponse authMe = getAuthMe(request, token);
        salesonContext.setUser(authMe);
        // 해당 토큰으로 회원 정보 조회후 세션에 다시 추가
        salesonContextHolder.setSalesonContext(request, salesonContext);
    }

    /**
     *  토큰으로 회원 인증정보 조회
     * @param token
     * @return
     * @throws Exception
     */
    public AuthMeResponse getAuthMe(HttpServletRequest request, String token) throws Exception{

        SalesonContext salesonContext = new SalesonContext(request);

        salesonContext.setToken(token);

        return salesonApi.get(salesonContext, "/api/auth/auth-me", AuthMeResponse.class);
    }

}
