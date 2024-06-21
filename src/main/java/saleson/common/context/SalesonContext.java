package saleson.common.context;

import com.fasterxml.jackson.annotation.JsonIgnore;
import saleson.common.enumeration.DeviceType;
import saleson.common.utils.FrontUtils;
import saleson.domains.auth.application.dto.AuthMeResponse;
import jakarta.servlet.http.HttpServletRequest;
import lombok.Getter;
import lombok.Setter;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;

@Getter
@Setter
public class SalesonContext {

    @JsonIgnore
    public static final String REQUEST_NAME = "OP_CONTEXT";

    private String salesonId = "";
    private String token = "";
    private AuthMeResponse user;
    private DeviceType deviceType;
    private String appVersion = "";
    private String requestUri;


    public SalesonContext(HttpServletRequest request) {
        setDeviceInfo(request);
    }

    public boolean isHasToken() {
        return !ObjectUtils.isEmpty(getToken());
    }

    public boolean isMobileFlag() {

        DeviceType type = getDeviceType();

        if (!ObjectUtils.isEmpty(type)) {
            if (DeviceType.ANDROID == type || DeviceType.IOS == type || DeviceType.MOBILE == type) {
                return true;
            }
        }

        return false;
    }

    public void setDeviceInfo(HttpServletRequest request) {
        this.deviceType = FrontUtils.getDeviceType(request);
        this.appVersion = FrontUtils.getAppVersion(request);
    }

    public long getUserId() {

        if (isHasToken() && !ObjectUtils.isEmpty(getUser())) {
            return getUser().getUserId();
        }

        return 0;
    }

    public boolean isGuestLogin() {


       if (!ObjectUtils.isEmpty(getUser())) {
           return "ROLE_GUEST".equals(getUser().getLoginType());
       } else
           return false;
    }

    public boolean isLogin() {
        return !ObjectUtils.isEmpty(getUser()) && !"ROLE_GUEST".equals(getUser().getLoginType());

    }

}
