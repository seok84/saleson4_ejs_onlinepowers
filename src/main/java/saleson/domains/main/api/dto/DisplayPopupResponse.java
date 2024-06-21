package saleson.domains.main.api.dto;

import jakarta.servlet.http.HttpServletRequest;
import lombok.*;
import org.springframework.util.ObjectUtils;
import saleson.common.utils.FrontUtils;
import saleson.domains.popup.application.dto.PopupResponse;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
@NoArgsConstructor
public class DisplayPopupResponse {

    List<PopupResponse> windows = new ArrayList<>();
    List<PopupResponse> layers = new ArrayList<>();

    public void set(HttpServletRequest request, List<PopupResponse> list) {

        if (!ObjectUtils.isEmpty(list)) {
            setWindows(filter(request, list, "WINDOW"));
            setLayers(filter(request, list, "LAYER"));

        }
    }

    private List<PopupResponse> filter(HttpServletRequest request, List<PopupResponse> list, String popupType) {
        return list.stream().filter(
                        p -> p.matched(popupType) && !isCached(request, p)
                )
                .collect(Collectors.toList());
    }

    private boolean isCached(HttpServletRequest request, PopupResponse popup) {
        return !ObjectUtils.isEmpty(FrontUtils.getCookie(request, popup.getCacheKey()));
    }
}
