package saleson.domains.mypage.application;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import saleson.common.api.infra.SalesonApi;
import saleson.common.context.SalesonContext;
import saleson.domains.mypage.application.dto.benefit.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class MypageBenefitService {

    private final SalesonApi salesonApi;

    // 쿠폰 조회
    public CouponInfoResponse getCoupon(SalesonContext salesonContext, CouponCriteria couponCriteria) throws Exception{

        CouponInfoResponse couponInfoResponse = salesonApi.get(salesonContext, "/api/coupon", salesonApi.convert(couponCriteria), CouponInfoResponse.class);
        return couponInfoResponse;

    }

    public CouponItemListResponse getAppliesTo(SalesonContext salesonContext, CouponCriteria couponCriteria, int couponId) throws Exception{
        return salesonApi.get(salesonContext, "/api/coupon/applies-to/"+couponId+"/coupon-user", salesonApi.convert(couponCriteria), CouponItemListResponse.class);

    }

    // 포인트 조회
    public PointInfoResponse getPoint(SalesonContext salesonContext, PointCriteria pointCriteria) throws Exception{

        PointInfoResponse pointInfoResponse = salesonApi.get(salesonContext, "/api/mypage/points", salesonApi.convert(pointCriteria), PointInfoResponse.class);
        return pointInfoResponse;

    }

    // 나의등급/혜택 조회
    public GradeResponse getGrade(SalesonContext salesonContext) throws Exception{
        GradeResponse gradeResponse = salesonApi.get(salesonContext, "/api/mypage/grade", GradeResponse.class);
        return gradeResponse;
    }

    // 다운가능 쿠폰리스트
    public CouponInfoResponse getCouponDownPopup(SalesonContext salesonContext, CouponCriteria couponCriteria) throws Exception{
        CouponInfoResponse couponInfoResponse = salesonApi.get(salesonContext, "/api/coupon/download-coupons", salesonApi.convert(couponCriteria), CouponInfoResponse.class);
        return couponInfoResponse;
    }
}
