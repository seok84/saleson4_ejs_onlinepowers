package saleson.domains.mypage.application.dto.info;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class UserDeliveryResponse {

    private String defaultFlag;

    private String title;

    private int userDeliveryId;

    private long userId;

    private String userName;

    private String mobile;

    private String phone;

    private String newZipcode;

    private String zipcode;

    private String sido;

    private String sigungu;

    private String eupmyeondong;

    private String address;

    private String addressDetail;
}
