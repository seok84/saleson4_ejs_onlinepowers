package saleson.domains.popup.application.dto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.cache.Cache;
import org.springframework.util.ObjectUtils;
import saleson.common.utils.FrontUtils;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PopupResponse {

    private int popupId;
    private String popupStatus;
    private String popupType;
    private String popupStyle;
    private String subject;
    private String content;
    private int width;
    private int height;
    private int topPosition;
    private int leftPosition;
    private String popupImage;
    private String imageLink;
    private String backgroundColor;

    public boolean matched(String popupType) {

        if (ObjectUtils.isEmpty(popupType)) {
            popupType = "";
        }

        return "PROGRESS".equals(getPopupStatus())
                && popupType.equals(getPopupType());
    }

    public String getCacheKey() {
        return "SALESON_POPUP_"+getPopupId();
    }
}
