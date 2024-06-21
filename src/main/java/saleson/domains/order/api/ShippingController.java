package saleson.domains.order.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.exception.SalesonApiException;
import saleson.common.context.SalesonContextHolder;
import saleson.common.pagination.PaginationHandler;
import saleson.common.utils.FrontUtils;
import saleson.domains.mypage.application.dto.info.ShippingItemPageResponse;
import saleson.domains.order.application.OrderService;
import saleson.domains.order.application.ShippingService;
import saleson.domains.order.application.dto.ShippingCriteria;
import saleson.domains.order.application.dto.UserDeliveryRequest;

@Controller
@RequestMapping("/shipping")
@RequiredArgsConstructor
@Slf4j
public class ShippingController {

    private final SalesonContextHolder salesonContextHolder;
    private final ShippingService shippingService;
    private final PaginationHandler paginationHandler;




    /**
     * 특정 회원 배송지 목록 조회 팝업
     * @param
     * @return
     */
    @GetMapping("/popup/address-list")
    public String popup(Model model, HttpServletRequest request) {
        model.addAttribute("title", "팝업메인");
        return "order/popup/address-list";
    }

    /**
     * 특정 회원 배송지 목록 조회
     * @param
     * @return
     */
    @GetMapping("/address-list")
    public String addressList(Model model, HttpServletRequest request, ShippingCriteria criteria) {
        model.addAttribute("title", "팝업메인");

        try {
            ShippingItemPageResponse pageContent = shippingService.getShippingItemPageResponse(salesonContextHolder.getSalesonContext(request), criteria);

            model.addAttribute("pageContent", pageContent);
            paginationHandler.setModelForUrl(model, "javascript:paginationShippingList([page])");

            return "order/include/address-list";
        } catch (Exception error) {
            throw new SalesonApiException(error);
        }
    }

    /**
     * 배송지 추가 팝업
     * @param
     * @return
     */
    @GetMapping("/popup/address-add")
    public String addPopup(Model model, HttpServletRequest request) {
        model.addAttribute("title", "팝업메인");
        try {

            model.addAttribute("userDelivery", new UserDeliveryRequest());
            return "order/popup/address";
        } catch (Exception error) {
            throw new SalesonApiException(error);
        }
    }

}
