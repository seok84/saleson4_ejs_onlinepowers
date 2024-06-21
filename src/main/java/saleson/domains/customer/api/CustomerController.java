package saleson.domains.customer.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.SalesonApi;
import saleson.common.api.infra.dto.Criteria;
import saleson.common.context.SalesonContext;
import saleson.common.context.SalesonContextHolder;
import saleson.common.enumeration.RedirectPageType;
import saleson.common.handler.FrontEventHandler;
import saleson.common.pagination.PaginationHandler;
import saleson.common.utils.FrontUtils;
import saleson.domains.customer.api.dto.FaqCriteria;
import saleson.domains.customer.api.dto.FaqPageResponse;
import saleson.domains.customer.api.dto.NoticePageResponse;
import saleson.domains.qna.application.QnaEventHandler;
import saleson.domains.qna.application.dto.QnaPageResponse;

@Controller
@RequestMapping("/customer")
@RequiredArgsConstructor
@Slf4j
public class CustomerController {

    private final SalesonContextHolder salesonContextHolder;
    private final PaginationHandler paginationHandler;
    private final FrontEventHandler frontEventHandler;
    private final SalesonApi salesonApi;
    private final QnaEventHandler qnaEventHandler;

    @GetMapping("/notice")
    public String notice(Model model, HttpServletRequest request, Criteria criteria) {

        model.addAttribute("pageContent",
            salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/notice", salesonApi.convert(criteria), NoticePageResponse.class));
        paginationHandler.setModelForPaginationUrl(model, request);
        frontEventHandler.setHeaderDetail(model, "고객센터");
        return "customer/notice";
    }

    @GetMapping("/faq")
    public String faq(Model model, HttpServletRequest request, FaqCriteria criteria) {

        model.addAttribute("pageContent",
                salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/faq", salesonApi.convert(criteria),FaqPageResponse.class));
        model.addAttribute("criteria", criteria);
        paginationHandler.setModelForPaginationUrl(model, request);
        frontEventHandler.setHeaderDetail(model, "고객센터");
        return "customer/faq";
    }

    @GetMapping("/store-inquiry")
    public String storeInquiry(Model model) {
        frontEventHandler.setHeaderDetail(model, "고객센터");
        return "customer/store-inquiry";
    }

    @GetMapping("/inquiry")
    public String inquiry(Model model, HttpServletRequest request, Criteria criteria) {

        SalesonContext salesonContext = salesonContextHolder.getSalesonContext(request);

        // 로그인이 안되어 있을경우
        if (!salesonContext.isHasToken()) {
            return "redrect:"+ RedirectPageType.LOGIN.getUrl() + "?target=" + request.getRequestURI();
        }

        QnaPageResponse pageContent = salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/qna/inquiry", salesonApi.convert(criteria), QnaPageResponse.class);

        qnaEventHandler.setConvertHtml(pageContent);

        model.addAttribute("pageContent", pageContent);
        model.addAttribute("criteria", criteria);
        paginationHandler.setModelForPaginationUrl(model, request);

        frontEventHandler.setHeaderDetail(model, "고객센터");

        return "customer/inquiry";
    }
}
