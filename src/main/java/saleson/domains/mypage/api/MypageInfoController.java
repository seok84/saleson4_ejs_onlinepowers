package saleson.domains.mypage.api;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import java.net.URLDecoder;
import java.util.Optional;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.dto.Criteria;
import saleson.common.context.SalesonContextHolder;
import saleson.common.handler.FrontEventHandler;
import saleson.common.pagination.PaginationHandler;
import saleson.common.utils.FrontUtils;
import saleson.domains.mypage.application.MypageInfoService;
import saleson.domains.mypage.application.dto.info.LatelyItemCriteria;
import saleson.domains.mypage.application.dto.info.OrderCriteria;
import saleson.domains.mypage.application.dto.info.OrderDetailResponse;
import saleson.domains.mypage.application.dto.info.OrderItemResponse;
import saleson.domains.mypage.application.dto.info.OrderRequest;
import saleson.domains.mypage.application.dto.info.ReviewRequest;

@Controller
@RequestMapping("/mypage/info")
@RequiredArgsConstructor
@Slf4j
public class MypageInfoController {

    private final SalesonContextHolder salesonContextHolder;
    private final MypageInfoService mypageInfoService;
    private final PaginationHandler paginationHandler;
    private final FrontEventHandler frontEventHandler;

    /**
     * 주문/배송조회
     * @param request
     * @param model
     * @return
     */
    @GetMapping("/order")
    public String order(HttpServletRequest request, Model model, OrderCriteria orderCriteria) throws Exception {

        model.addAttribute("criteria", orderCriteria);
        model.addAttribute("pageContent", mypageInfoService.getOrder(salesonContextHolder.getSalesonContext(request), orderCriteria));
        paginationHandler.setModelForPaginationUrl(model, request);

        frontEventHandler.setHeaderDetail(model, "주문/배송 조회");
        return "mypage/info/order";
    }

    /**
     * 주문/배송 상세조회
     * @param model
     * @return
     */
    @GetMapping("/order-detail/{orderCode}")
    public String orderDetail(HttpServletRequest request, Model model, @PathVariable("orderCode") String orderCode) throws Exception {

        model.addAttribute("content", mypageInfoService.getOrderDetail(salesonContextHolder.getSalesonContext(request), orderCode));

        frontEventHandler.setHeaderDetail(model, "주문/배송 상세조회");

        return "mypage/info/order-detail";
    }

    /**
     * 취소/교환/반품/조회
     * @param model
     * @return
     */
    @GetMapping("/claim")
    public String claim(HttpServletRequest request, Model model, OrderCriteria orderCriteria) throws Exception {

        if (ObjectUtils.isEmpty(orderCriteria.getStatusType())){
            orderCriteria.setStatusType("cancel-process");
        }
        model.addAttribute("criteria", orderCriteria);
        model.addAttribute("tabClass", claimTabClass(orderCriteria.getStatusType()));
        model.addAttribute("pageContent", mypageInfoService.getOrder(salesonContextHolder.getSalesonContext(request), orderCriteria));

        frontEventHandler.setHeaderDetail(model, "취소/교환/반품 조회");

        return "mypage/info/claim";
    }

    /**
     * 관심상품
     * @param model
     * @return
     */
    @GetMapping("/wishlist")
    public String wishlist(HttpServletRequest request, Model model, Criteria criteria) throws Exception {
        criteria.setSize(6);
        model.addAttribute("pageContent", mypageInfoService.getWishlist(salesonContextHolder.getSalesonContext(request),criteria));
        paginationHandler.setModelForPaginationUrl(model, request);

        frontEventHandler.setHeaderDetail(model, "관심상품");
        return "mypage/info/wishlist";
    }

    /**
     * 최근 본 상품
     * @param model
     * @return
     */
    @GetMapping("/recent-item")
    public String recentItem(HttpServletRequest request, Model model, LatelyItemCriteria latelyItemCriteria) throws Exception {

        latelyItemCriteria.setIds(frontEventHandler.getLatelyItemIds(request));

        model.addAttribute("pageContent", mypageInfoService.getRecentItem(salesonContextHolder.getSalesonContext(request),latelyItemCriteria));

        frontEventHandler.setHeaderDetail(model, "최근 본 상품");
        return "mypage/info/recent-item";
    }

    /**
     * 배송주소록 관리
     * @param model
     * @return
     */
    @GetMapping("/delivery")
    public String delivery(HttpServletRequest request, Model model) throws Exception {
        frontEventHandler.setHeaderDetail(model,"배송주소록 관리");
        model.addAttribute("pageContent", mypageInfoService.getDelivery(salesonContextHolder.getSalesonContext(request)));
        return "mypage/info/delivery";
    }
    
    // 교환신청 팝업
    @GetMapping("/popup/exchange-apply")
    public String getExchangePopup(HttpServletRequest request, Model model, OrderRequest orderRequest) throws Exception{
        frontEventHandler.setHeaderDetail(model,"교환신청 팝업");
        model.addAttribute("orderRequest", orderRequest);
        model.addAttribute("content", mypageInfoService.getExchangePopup(salesonContextHolder.getSalesonContext(request), orderRequest));
        return "mypage/info/popup/exchange";
    }

    // 반품신청 팝업
    @GetMapping("/popup/return-apply")
    public String getReturnPopup(HttpServletRequest request, Model model, OrderRequest orderRequest) throws Exception{
        frontEventHandler.setHeaderDetail(model,"반품신청 팝업");
        model.addAttribute("orderRequest", orderRequest);
        mypageInfoService.getReturnPopup(request, model, orderRequest);
        return "mypage/info/popup/return";
    }

    // 취소신청 팝업
    @GetMapping("/popup/cancel-apply")
    public String getCancelPopup(HttpServletRequest request, Model model, OrderRequest orderRequest) throws Exception{
        frontEventHandler.setHeaderDetail(model,"취소신청 팝업");
        model.addAttribute("orderRequest", orderRequest);
        mypageInfoService.getCancelPopup(request, model, orderRequest);
        return "mypage/info/popup/cancel";
    }

    private String claimTabClass(String statusType){

        String className = "";
        switch (statusType) {
            case"cancel-process":
                className = "tab-cancel"; break;
            case"return-process":
                className = "tab-return"; break;
            case"exchange-process":
                className = "tab-exchange"; break;
            default:
        }
        return className;
    }

    // 이용후기 팝업
    @GetMapping("/popup/review")
    public String getReviewPopup(
        HttpServletRequest request, Model model, ReviewRequest reviewRequest) throws Exception{

        frontEventHandler.setHeaderDetail(model,"이용후기 팝업");

        OrderDetailResponse orderDetailResponse = mypageInfoService.getOrderDetail(salesonContextHolder.getSalesonContext(request), reviewRequest.getOrderCode());
        Optional<OrderItemResponse> orderItemResponse = orderDetailResponse.getItem().stream()
            .filter(i -> i.getItemUserCode().equals(reviewRequest.getItemUserCode()) && i.getItemSequence() == reviewRequest.getItemSequence())
            .findFirst();

        model.addAttribute("content", orderItemResponse.get());
        model.addAttribute("orderCode", orderDetailResponse.getOrderCode());

        return "mypage/info/popup/review";
    }
}
