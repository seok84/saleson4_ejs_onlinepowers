package saleson.domains.item.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.SalesonApi;
import saleson.common.api.infra.dto.CodeListResponse;
import saleson.common.api.infra.dto.Criteria;
import saleson.common.async.application.AsyncDataService;
import saleson.common.async.application.dto.AsyncDataRequest;
import saleson.common.context.SalesonContextHolder;
import saleson.common.enumeration.HeaderStyleType;
import saleson.common.handler.FrontEventHandler;
import saleson.common.pagination.PaginationHandler;
import saleson.common.utils.FrontUtils;
import saleson.domains.item.application.dto.ItemDetailFrontResponse;
import saleson.domains.item.application.dto.ItemListResponse;
import saleson.domains.item.application.dto.ItemPageResponse;
import saleson.domains.mypage.application.dto.benefit.CouponPageResponse;
import saleson.domains.qna.application.QnaEventHandler;
import saleson.domains.qna.application.dto.ItemQnaPageResponse;
import saleson.domains.review.application.dto.ReviewCriteria;
import saleson.domains.review.application.dto.ReviewPageResponse;

@RequiredArgsConstructor
@Controller
@RequestMapping("/item")
@Slf4j
public class ItemController {

    private final SalesonContextHolder salesonContextHolder;
    private final PaginationHandler paginationHandler;
    private final FrontEventHandler frontEventHandler;
    private final SalesonApi salesonApi;
    private final QnaEventHandler qnaEventHandler;
    private final AsyncDataService asyncDataService;

    @GetMapping("/{itemUserCode}")
    public String view(Model model, HttpServletRequest request,
                       @PathVariable("itemUserCode") String itemUserCode) {

        asyncDataService.setModelBy(request, model,
                new AsyncDataRequest<>("item", "/api/item/" + itemUserCode, HttpMethod.GET, ItemDetailFrontResponse.class),
                new AsyncDataRequest<>("qnaGroups", "/api/qna/qna-groups", HttpMethod.GET, CodeListResponse.class)
        );

        model.addAttribute("isLogin", salesonContextHolder.getSalesonContext(request).isLogin());
        frontEventHandler.setHeader(model, HeaderStyleType.ITEM_DETAIL);
        frontEventHandler.setHiddenMobileGnb(model);
        return "item/view";
    }

    @GetMapping("/{itemUserCode}/relation")
    public String relationItems(Model model, HttpServletRequest request,
                                @PathVariable("itemUserCode") String itemUserCode) {

        asyncDataService.setModelBy(request, model,
                new AsyncDataRequest<>("itemList", "/api/item/" + itemUserCode + "/relation", HttpMethod.GET, ItemListResponse.class)
        );

        return "item/include/relations";
    }

    @GetMapping("/{itemUserCode}/coupon-down")
    public String couponDown(@PathVariable("itemUserCode") String itemUserCode, Model model, HttpServletRequest request) {
        model.addAttribute("title", "다운로드 가능쿠폰 팝업");

        asyncDataService.setModelBy(request, model,
                new AsyncDataRequest<>("pageContent", "/api/item/" + itemUserCode + "/coupons", HttpMethod.GET, CouponPageResponse.class)
        );

        return "mypage/benefit/popup/coupon-down";
    }

    @GetMapping("/result")
    public String result(Model model, HttpServletRequest request, Criteria criteria) {

        try {
            criteria.setSize(24);

            asyncDataService.setModelBy(request, model,
                    new AsyncDataRequest<>("pageContent", "/api/search/result", HttpMethod.GET, ItemPageResponse.class, salesonApi.convert(criteria))
            );

            model.addAttribute("criteria", criteria);
            paginationHandler.setModelForPaginationUrl(model, request);
            frontEventHandler.setHeader(model, HeaderStyleType.SEARCH);
        } catch (Exception e) {
            log.error("item search page content error {}", e.getMessage(), e);
        }

        return "item/result";
    }

    @GetMapping("{itemUserCode}/inquiry")
    public String inquiry(@PathVariable("itemUserCode") String itemUserCode,
                          Model model, HttpServletRequest request, Criteria criteria) {

        try {
            String url = "/api/item/" + itemUserCode + "/inquiry";

            asyncDataService.setModelBy(request, model,
                    new AsyncDataRequest<>("pageContent", url, HttpMethod.GET, ItemQnaPageResponse.class, salesonApi.convert(criteria))
            );

            ItemQnaPageResponse pageContent = (ItemQnaPageResponse) model.getAttribute("pageContent");

            qnaEventHandler.setConvertHtml(pageContent);

            model.addAttribute("pageContent", pageContent);
        } catch (Exception e) {
            log.error("item inquiry error [{}] => {}", itemUserCode, e.getMessage(), e);
        }

        model.addAttribute("criteria", criteria);

        paginationHandler.setModelForUrl(model, "javascript:paginationInquiry([page])");

        return "item/include/inquiry-list";
    }

    @GetMapping("{itemUserCode}/review")
    public String review(@PathVariable("itemUserCode") String itemUserCode,
                         Model model, HttpServletRequest request, ReviewCriteria criteria) {

        try {
            String url = "/api/item/reviews";

            criteria.setItemUserCode(itemUserCode);

            asyncDataService.setModelBy(request, model,
                    new AsyncDataRequest<>("pageContent", url, HttpMethod.GET, ReviewPageResponse.class, salesonApi.convert(criteria))
            );

            ReviewPageResponse pageContent = (ReviewPageResponse) model.getAttribute("pageContent");

            if (!ObjectUtils.isEmpty(pageContent) && !ObjectUtils.isEmpty(pageContent.getContent())) {
                pageContent.getContent().forEach(c -> {
                    c.setContent(FrontUtils.nl2br(c.getContent()));
                    c.setAdminComment(FrontUtils.nl2br(c.getAdminComment()));
                });
            }

            model.addAttribute("pageContent", pageContent);
        } catch (Exception e) {
            log.error("item review error [{}] => {}", itemUserCode, e.getMessage(), e);
        }

        model.addAttribute("criteria", criteria);

        paginationHandler.setModelForUrl(model, "javascript:paginationReview([page])");

        return "item/include/review-list";
    }

}
