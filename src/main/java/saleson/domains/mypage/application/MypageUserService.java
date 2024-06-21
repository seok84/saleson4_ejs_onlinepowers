package saleson.domains.mypage.application;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import saleson.common.api.infra.SalesonApi;
import saleson.common.async.application.AsyncDataService;
import saleson.common.context.SalesonContext;
import saleson.domains.review.application.dto.ReviewCriteria;
import saleson.domains.review.application.dto.ReviewInfoResponse;
import saleson.domains.review.application.dto.ReviewListResponse;
import saleson.domains.mypage.application.dto.user.SecedeResponse;
import saleson.domains.mypage.application.dto.user.SnsInfoListResponse;
import saleson.domains.mypage.application.dto.user.UserInfoResponse;

@Service
@RequiredArgsConstructor
@Slf4j
public class MypageUserService {

    private final SalesonApi salesonApi;
    private final AsyncDataService asyncDataService;

    // 후기작성 팝업정보
    public ReviewInfoResponse getReviewPopup(SalesonContext salesonContext, String itemUserCode){
        ReviewInfoResponse reviewInfoResponse = salesonApi.get(salesonContext, "/review/info/"+itemUserCode, ReviewInfoResponse.class);
        return reviewInfoResponse;
    }

    public SecedeResponse getSecedeInfo(SalesonContext salesonContext) {
        SecedeResponse secedeResponse = salesonApi.get(salesonContext, "/api/auth/secede", SecedeResponse.class);
        return secedeResponse;
    }

    public UserInfoResponse getMe(SalesonContext salesonContext) {
        UserInfoResponse userInfoResponse = salesonApi.get(salesonContext, "/api/auth/me", UserInfoResponse.class);
        return userInfoResponse;
    }

    public SnsInfoListResponse getSnsInfo(SalesonContext salesonContext) {
        SnsInfoListResponse snsInfoListResponse = salesonApi.get(salesonContext, "/api/auth/sns-info", SnsInfoListResponse.class);
        return snsInfoListResponse;
    }


    public ReviewListResponse getReviewList(SalesonContext salesonContext, ReviewCriteria reviewCriteria) {
         ReviewListResponse reviewListResponse = salesonApi.get(salesonContext, "/api/mypage/reviews",salesonApi.convert(reviewCriteria), ReviewListResponse.class);
        return reviewListResponse;
    }
}
