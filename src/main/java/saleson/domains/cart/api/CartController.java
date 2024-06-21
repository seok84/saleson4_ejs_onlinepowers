package saleson.domains.cart.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import saleson.common.api.infra.exception.SalesonApiException;
import saleson.common.context.SalesonContextHolder;
import saleson.common.handler.FrontEventHandler;
import saleson.domains.cart.application.CartService;

@Controller
@RequiredArgsConstructor
@RequestMapping ("/cart")
@Slf4j
public class CartController {

    private final SalesonContextHolder salesonContextHolder;

    private final CartService cartService;
    private final FrontEventHandler frontEventHandler;

    @GetMapping("")
    public String index(Model model, RedirectAttributes ra, HttpServletRequest request) throws Exception {

        try {
            boolean isLogin = !ObjectUtils.isEmpty(salesonContextHolder.getSalesonContext(request).getUser()) ? true : false;

            model.addAttribute("response", cartService.getCartItems(salesonContextHolder.getSalesonContext(request)));
            model.addAttribute("isLogin", isLogin);

        } catch (SalesonApiException e) {
            throw new SalesonApiException(e, "/");
        }

        frontEventHandler.setHeaderDetail(model, "장바구니");
        frontEventHandler.setHiddenMobileGnb(model);

        return "cart/index";
    }

    @GetMapping("/popup/{cartId}")
    public String popup(Model model, HttpServletRequest request, @PathVariable("cartId") int cartId) {
        model.addAttribute("title", "팝업메인");

        try {
            model.addAttribute("response", cartService.getCartItemById(salesonContextHolder.getSalesonContext(request), cartId));
        } catch (Exception error) {
            log.error("error = {}", error.getMessage());
            throw new SalesonApiException(error);
        }

        return "include/buyItem/popup/item-detail";
    }

}
