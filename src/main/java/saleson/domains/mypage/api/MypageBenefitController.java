package saleson.domains.mypage.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.context.SalesonContextHolder;
import saleson.common.handler.FrontEventHandler;
import saleson.common.pagination.PaginationHandler;
import saleson.domains.mypage.application.MypageBenefitService;
import saleson.domains.mypage.application.dto.benefit.*;

@Controller
@RequestMapping("/mypage/benefit")
@RequiredArgsConstructor
@Slf4j
public class MypageBenefitController {

    private final SalesonContextHolder salesonContextHolder;
    private final MypageBenefitService mypageBenefitService;
    private final PaginationHandler paginationHandler;
    private final FrontEventHandler frontEventHandler;
    /**
     * 쿠폰
     * @param model
     * @return
     */
    @GetMapping("/coupon")
    public String coupon(HttpServletRequest request, Model model, CouponCriteria couponCriteria) throws Exception {

        CouponInfoResponse couponInfoResponse = mypageBenefitService.getCoupon(salesonContextHolder.getSalesonContext(request), couponCriteria);

        model.addAttribute("pageContent", couponInfoResponse.getCouponPageResponse());
        paginationHandler.setModelForPaginationUrl(model, request);

        model.addAttribute("completedUserCouponCount", couponInfoResponse.getCompletedUserCouponCount());
        model.addAttribute("availableCount", couponInfoResponse.getAvailableCount());
        model.addAttribute("tabClass", couponCriteria.isComplete());

        frontEventHandler.setHeaderDetail(model, "쿠폰");

        return "mypage/benefit/coupon";
    }

    @GetMapping("/coupon/popup/{couponId}/applies-to")
    public String appliesTo(HttpServletRequest request, Model model,
                            @PathVariable("couponId") int couponId,
                            CouponCriteria criteria) throws Exception {

        CouponItemListResponse itemListResponse
                = mypageBenefitService.getAppliesTo(salesonContextHolder.getSalesonContext(request), criteria, couponId);

        model.addAttribute("pageContent", itemListResponse.getPageContent());
        paginationHandler.setModelForUrl(model, "javascript:paginationAppliesToCoupon([page])");

        return "mypage/benefit/popup/applies-to";
    }

    /**
     * 포인트
     * @param model
     * @return
     */
    @GetMapping("/point")
    public String point(HttpServletRequest request, Model model, PointCriteria pointCriteria) throws Exception {

        PointInfoResponse pointInfoResponse = mypageBenefitService.getPoint(salesonContextHolder.getSalesonContext(request), pointCriteria);
        model.addAttribute("criteria", pointCriteria);
        model.addAttribute("pageContent", pointInfoResponse.getPointPageResponse());
        paginationHandler.setModelForPaginationUrl(model, request);

        model.addAttribute("content", pointInfoResponse.getContent());
        model.addAttribute("tabClass", pointTabClass(pointCriteria.getPointType()));

        frontEventHandler.setHeaderDetail(model, "포인트");

        return "mypage/benefit/point";
    }

    /**
     * 나의등급/혜택
     * @param model
     * @return
     */
    @GetMapping("/grade")
    public String grade(HttpServletRequest request, Model model) throws Exception {

        model.addAttribute("content",mypageBenefitService.getGrade(salesonContextHolder.getSalesonContext(request)));

        frontEventHandler.setHeaderDetail(model, "나의등급/혜택");

        return "mypage/benefit/grade";
    }

    private String pointTabClass(String pointType){

        String className = "";
        if (ObjectUtils.isEmpty(pointType)){
            pointType = "EARN_POINT";
        }
        switch (pointType) {
            case"EARN_POINT":
                className = "possible"; break;
            case"USED_POINT":
                className = "complete"; break;
            default:
        }
        return className;
    }

    /**
     * 다운가능 쿠폰 리스트
     * @param model
     * @return
     */
    @GetMapping("/popup/coupon-down")
    public String getCouponDownPopup(HttpServletRequest request, Model model, CouponCriteria couponCriteria) throws Exception{
        model.addAttribute("title", "다운로드 가능쿠폰 팝업");
        CouponInfoResponse couponInfoResponse = mypageBenefitService.getCouponDownPopup(salesonContextHolder.getSalesonContext(request), couponCriteria);
        model.addAttribute("pageContent", couponInfoResponse.getCouponPageResponse());
        paginationHandler.setModelForUrl(model, "javascript:paginationCouponDownList([page])");

        model.addAttribute("totalCount", couponInfoResponse.getDownloadAvailableCount());
        return "mypage/benefit/popup/coupon-down";
    }
}
