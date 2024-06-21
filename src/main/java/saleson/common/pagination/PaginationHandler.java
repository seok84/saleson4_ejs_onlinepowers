package saleson.common.pagination;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import saleson.common.utils.FrontUtils;

@Component
public class PaginationHandler {

    public void setModelForUrl(Model model, String url) {
        model.addAttribute("url", url);
    }

    public void setModelForPaginationUrl(Model model, HttpServletRequest request) {
        model.addAttribute("paginationUrl", getPaginationUrl(request));
    }

    private String getPaginationUrl(HttpServletRequest request) {
        String qString = "";
        String queryString = FrontUtils.getQueryString(request);
        if (!ObjectUtils.isEmpty(queryString)) {
            queryString = queryString.replaceAll("&lang=[a-z]+", "").replaceAll("lang=[a-z]+", "");
        }

        if (!ObjectUtils.isEmpty(queryString)) {
            if (queryString.indexOf("page=") == -1) {
                qString = queryString + "&page=[page]";
            } else {
                qString = queryString.replaceAll("page=[0-9]+", "page=[page]");
            }
        } else {
            qString = "page=[page]";
        }

        String url = FrontUtils.getRequestUri(request);
        return url + "?" + qString;
    }
}
