package saleson.domains.featured.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.SalesonApi;
import saleson.common.context.SalesonContextHolder;
import saleson.common.handler.FrontEventHandler;
import saleson.common.pagination.PaginationHandler;
import saleson.common.utils.FrontUtils;
import saleson.domains.featured.api.dto.FeaturedDetailResponse;
import saleson.domains.featured.api.dto.FeaturedPageResponse;
import saleson.domains.featured.api.dto.FeaturedRepliesCriteria;
import saleson.domains.featured.api.dto.FeaturedReplyPageResponse;

@Controller
@RequestMapping("/featured")
@RequiredArgsConstructor
@Slf4j
public class FeaturedController {
    private final SalesonContextHolder salesonContextHolder;
    private final SalesonApi salesonApi;
    private final PaginationHandler paginationHandler;
    private final FrontEventHandler frontEventHandler;

    @GetMapping("")
    public String list(Model model, HttpServletRequest request) {

        model.addAttribute("pageContent", salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/event", FeaturedPageResponse.class));
        paginationHandler.setModelForPaginationUrl(model, request);

        return "featured/list";
    }

    @GetMapping("pages/{url}")
    public String pages(@PathVariable("url") String url, Model model, HttpServletRequest request) {

        model.addAttribute("featured", salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/event/"+url, FeaturedDetailResponse.class));
        frontEventHandler.setHeaderDetail(model, "이벤트");

        return "featured/view";
    }

    @GetMapping("replies")
    public String pages(Model model, HttpServletRequest request, FeaturedRepliesCriteria criteria) {

        FeaturedReplyPageResponse pageContent = salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/event/replies", salesonApi.convert(criteria), FeaturedReplyPageResponse.class);

        if (!ObjectUtils.isEmpty(pageContent) && !ObjectUtils.isEmpty(pageContent.getContent())) {
            pageContent.getContent().forEach(c->{
              c.setContent(FrontUtils.nl2br(c.getContent()));
            });
        }

        model.addAttribute("pageContent", pageContent);

        paginationHandler.setModelForUrl(model, "javascript:paginationFeaturedReply([page])");

        return "featured/include/replies";
    }
}
