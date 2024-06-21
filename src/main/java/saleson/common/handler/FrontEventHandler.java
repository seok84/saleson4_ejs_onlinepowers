package saleson.common.handler;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
import saleson.common.configuration.saleson.SalesonSocialConfig;
import saleson.common.enumeration.HeaderStyleType;
import saleson.common.utils.FrontUtils;
import saleson.domains.item.application.dto.ItemListResponse;
import saleson.domains.item.application.dto.ItemPageResponse;
import saleson.domains.item.application.dto.ItemResponse;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class FrontEventHandler {

    private final SalesonSocialConfig salesonSocialConfig;

    public void setHeader(Model model, HeaderStyleType headerStyleType) {
        model.addAttribute("headerStyleType", headerStyleType.name());
    }

    /**
     * 상세페이지 헤더 스타일 적용
     *
     * @param model
     * @param title
     */
    public void setHeaderDetail(Model model, String title) {
        setHeaderDetail(model, title, "");
    }

    /**
     * 상세페이지 헤더 스타일 적용
     *
     * @param model
     * @param title
     * @param historyBackUrl
     */
    public void setHeaderDetail(Model model, String title, String historyBackUrl) {

        model.addAttribute("headerStyleType", HeaderStyleType.DETAIL.name());
        model.addAttribute("headerTitle", title);
        model.addAttribute("headerHistoryBackUrl", historyBackUrl);
    }

    public void setHiddenMobileGnb(Model model) {
        model.addAttribute("hiddenMobileGnbFlag", true);
    }

    /**
     * 최근 본 상품 목록 문자열
     *
     * @param request
     * @return
     */
    public String getLatelyItemIds(HttpServletRequest request) {
        try {
            Cookie cookie = FrontUtils.getCookie(request, "latelyItem");
            if (!ObjectUtils.isEmpty(cookie)) {
                return URLDecoder.decode(cookie.getValue(), "UTF-8");
            }
        } catch (Exception e) {
        }
        return "";
    }

    public String[] getLatelySearchList(HttpServletRequest request) {
        try {
            Cookie cookie = FrontUtils.getCookie(request, "latelySearch");
            if (!ObjectUtils.isEmpty(cookie)) {

                String decode = URLDecoder.decode(cookie.getValue(), "UTF-8");
                return StringUtils.delimitedListToStringArray(decode, ",");
            }
        } catch (Exception e) {
        }
        return new String[0];
    }

    public void setSocialConfig(Model model) {
        model.addAttribute("socialConfig", salesonSocialConfig);
    }

    public void setPreloadImageLinkTag(Model model, List<String> images) {
        if (!ObjectUtils.isEmpty(images)) {
            model.addAttribute("preloadImageLinkTagList", images);
        }
    }

    public void setPreloadImageLinkTag(Model model, ItemPageResponse response) {
        if (!ObjectUtils.isEmpty(response) && !ObjectUtils.isEmpty(response.getContent())) {
            List<String> images = new ArrayList<>();

            response.getContent().stream()
                    .filter(i -> !ObjectUtils.isEmpty(i.getItemImage()))
                    .forEach(i -> {
                        images.add(i.getItemImage());
                    });

            setPreloadImageLinkTag(model, images);
        }
    }
}
