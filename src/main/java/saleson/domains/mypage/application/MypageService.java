package saleson.domains.mypage.application;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import saleson.common.api.infra.SalesonApi;
import saleson.common.context.SalesonContext;
import saleson.domains.mypage.application.dto.CouponAndPointResponse;
import saleson.domains.mypage.application.dto.MypageHeaderResponse;
import saleson.domains.mypage.application.dto.MypageResponse;
import saleson.domains.mypage.application.dto.user.UserInfoResponse;

@Service
@RequiredArgsConstructor
@Slf4j
public class MypageService {

    private final SalesonApi salesonApi;

    public MypageResponse index(SalesonContext salesonContext) throws Exception {
        MypageResponse mypageResponse = salesonApi.get(salesonContext, "/api/mypage", MypageResponse.class);
        return mypageResponse;
    }

    public void mypageHeader(ModelAndView modelAndView, SalesonContext salesonContext){

        UserInfoResponse userInfoResponse = salesonApi.get(salesonContext, "/api/auth/me", UserInfoResponse.class);
        CouponAndPointResponse couponAndPointResponse = salesonApi.get(salesonContext, "/api/mypage/coupon-and-point", CouponAndPointResponse.class);

        modelAndView.addObject("mypageHeader", MypageHeaderResponse.builder()
            .userName(userInfoResponse.getUserName())
            .levelName(userInfoResponse.getLevelName())
            .point(couponAndPointResponse.getPoint())
            .couponCount(couponAndPointResponse.getCouponCount()).build());
    }

}
