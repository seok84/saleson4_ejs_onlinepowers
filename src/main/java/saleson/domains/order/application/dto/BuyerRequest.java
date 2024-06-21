package saleson.domains.order.application.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BuyerRequest {
    private long userId;
    private String loginId;
    private String userName;
    private String phone;
    private String mobile;
    private String email;

    private String zipcode;
    private String newZipcode;
    private String sido;
    private String sigungu;
    private String eupmyeondong;
    private String address;
    private String addressDetail;

}
