package saleson.domains.eventview.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.SalesonApi;
import saleson.common.context.SalesonContext;
import saleson.common.context.SalesonContextHolder;
import saleson.common.utils.FrontUtils;
import saleson.domains.eventview.api.dto.EventViewResponse;

@Controller
@RequestMapping("/ev")
@RequiredArgsConstructor
@Slf4j
public class EventViewController {

    private final SalesonContextHolder salesonContextHolder;
    private final SalesonApi salesonApi;

    @GetMapping("/{code}/{id}")
    public String redirect(HttpServletRequest request,
                                   @PathVariable("code") String code,
                                   @PathVariable("id") long userId) {

        return "redirect:" + getRedirect(request);
    }

    @GetMapping("/{code}")
    public String redirect(HttpServletRequest request,
                                   @PathVariable("code") String code) {

        return "redirect:" + getRedirect(request);
    }

    @GetMapping("/c/{code}/{id}")
    public String campaign(HttpServletRequest request,
                                   @PathVariable("code") String code,
                                   @PathVariable("id") long userId) {

        return "redirect:" + getRedirect(request);
    }

    @GetMapping("/c/{code}")
    public String campaign(HttpServletRequest request,
                                   @PathVariable("code") String code) {

        return "redirect:" + getRedirect(request);
    }

    @GetMapping("/s/{code}/{id}")
    public String share(HttpServletRequest request,
                                @PathVariable("code") String itemUserCode,
                                @PathVariable("id") long userId) {

        return "redirect:" + getRedirect(request);
    }

    @GetMapping("/s/{code}")
    public String share(HttpServletRequest request,
                                @PathVariable("code") String itemUserCode) {

        return "redirect:" + getRedirect(request);
    }

    @GetMapping("/ep/{channel}/{code}")
    public String epItem(HttpServletRequest request,
                                 @PathVariable("code") String itemUserCode,
                                 @PathVariable("channel") String channel) {

        return "redirect:" + getRedirect(request);
    }

    @GetMapping("/e/{code}")
    public String event(HttpServletRequest request,
                                @PathVariable("code") String code) {

        return "redirect:" + getRedirect(request);
    }

    @GetMapping("/e/{code}/{id}")
    public String event(HttpServletRequest request,
                        @PathVariable("code") String code,
                        @PathVariable("id") long userId) {

        return "redirect:" + getRedirect(request);
    }

    private String getRedirect(HttpServletRequest request) {
        String requestUri = FrontUtils.getRequestUri(request);

        String redirectEventView = "/";

        try {
            SalesonContext context = salesonContextHolder.getSalesonContext(request);
            EventViewResponse eventView = salesonApi.get(context, "/api/" + requestUri, EventViewResponse.class);

            if (ObjectUtils.isEmpty(eventView)) {
                throw new IllegalArgumentException("not event view");
            }

            if (ObjectUtils.isEmpty(eventView.getUrl())) {
                throw new IllegalArgumentException("not event view url");
            }

            redirectEventView = eventView.getUrl();

        } catch (Exception e) {
            log.error("redirect event view error [{}] {}", requestUri, e.getMessage(), e);
        }

        return redirectEventView;
    }
}
