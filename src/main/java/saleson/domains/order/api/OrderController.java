package saleson.domains.order.api;

import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import saleson.common.api.infra.exception.SalesonApiException;
import saleson.common.context.SalesonContextHolder;
import saleson.common.handler.FrontEventHandler;
import saleson.common.view.JsonView;
import saleson.domains.mypage.application.MypageInfoService;
import saleson.domains.mypage.application.dto.info.OrderDetailResponse;
import saleson.domains.mypage.application.dto.info.OrderRequest;
import saleson.domains.order.application.OrderService;
import saleson.domains.order.application.dto.BuyRequest;
import saleson.domains.order.application.dto.BuyResponse;

@Controller
@RequestMapping("/order")
@RequiredArgsConstructor
@Slf4j
public class OrderController {

    private final SalesonContextHolder salesonContextHolder;
    private final OrderService orderService;
    private final MypageInfoService mypageInfoService;
    private final FrontEventHandler frontEventHandler;

    @GetMapping("/step1")
    public String paymentStep(Model model, RedirectAttributes ra, HttpServletRequest request) {
        try {
            boolean isLogin = salesonContextHolder.getSalesonContext(request).isLogin();

            model.addAttribute("isLogin", isLogin);
            model.addAttribute("response", orderService.getPaymentResponse(salesonContextHolder.getSalesonContext(request)));
            model.addAttribute("buyRequest", new BuyRequest());


            frontEventHandler.setHeaderDetail(model, "주문하기");
            frontEventHandler.setHiddenMobileGnb(model);
        } catch (SalesonApiException e) {
            throw new SalesonApiException(e, "/cart");
        }

        return "order/step1";
    }

    @GetMapping("/no-member")
    public String noMember(Model model, HttpServletRequest request) {
        frontEventHandler.setHeaderDetail(model,"비회원 주문처리페이지 메인");

        return "order/no-member";
    }

    @PostMapping("/convert-form")
    @ResponseBody
    public JsonView convert(BuyRequest buyRequest) {
        return JsonView.builder().successFlag(true).data(buyRequest).build();
    }

    @GetMapping("/popup/coupons")
    public String coupons(Model model, HttpServletRequest request) {
        try {
            model.addAttribute("response", orderService.getCoupons(salesonContextHolder.getSalesonContext(request)));
        } catch (SalesonApiException e) {
            throw new SalesonApiException(e);
        }

        return "order/popup/apply-coupon";
    }

    @GetMapping("/step2")
    public String step2(Model model, HttpServletRequest request, HttpServletResponse response, OrderRequest orderRequest, RedirectAttributes redirectAttributes) throws Exception {
        String redirectPage = "order/step2";
        OrderDetailResponse orderDetailResponse = mypageInfoService.getOrderDetail(salesonContextHolder.getSalesonContext(request), orderRequest.getOrderCode());

        // 주문이 없는 경우 메인으로 리다이렉트
        if (ObjectUtils.isEmpty(orderDetailResponse.getOrderCode())){
            response.sendRedirect("/");
        } else {
            model.addAttribute("content", orderDetailResponse);
            frontEventHandler.setHeaderDetail(model, "주문완료");
        }
        return redirectPage;
    }


    @GetMapping("/popup/set-item-info/{itemId}")
    public String setItemInfo(Model model, HttpServletRequest request, @PathVariable("itemId") int itemId) {
        try {

            model.addAttribute("response", orderService.getSetItemInfos(salesonContextHolder.getSalesonContext(request), itemId));
        } catch (SalesonApiException e) {
            throw new SalesonApiException(e);
        }


        return "include/buyItem/popup/item-detail";
    }

}
