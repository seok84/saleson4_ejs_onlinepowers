package saleson.domains.mypage.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.SalesonApi;
import saleson.common.context.SalesonContextHolder;
import saleson.common.handler.FrontEventHandler;
import saleson.domains.mypage.application.MypageService;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
@Slf4j
public class MypageController {

    private final SalesonContextHolder salesonContextHolder;
    private final MypageService mypageService;
    private final FrontEventHandler frontEventHandler;

    @GetMapping("")
    public String index(HttpServletRequest request, Model model) throws Exception {

        model.addAttribute("title", "마이페이지 메인");
        model.addAttribute("content", mypageService.index(salesonContextHolder.getSalesonContext(request)));

        frontEventHandler.setHeaderDetail(model, "마이페이지 메인");
        return "mypage/index";

    }

//    @GetMapping("shipping")
//    public String shipping(HttpServletRequest request, Model model) {
//
//        try {
//            model.addAttribute("pageContent",
//                    salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/shipping", ShippingPageResponse.class));
//        } catch (Exception e) {
//            log.error("shipping error {}",e.getMessage(), e);
//        }
//
//        model.addAttribute("title", "배송목록");
//        return "mypage/shipping";
//    }
}
