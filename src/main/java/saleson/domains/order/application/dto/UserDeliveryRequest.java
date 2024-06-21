package saleson.domains.order.application.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
public class UserDeliveryRequest {

    private int userDeliveryId;

    private long userId;


    @NotEmpty
    private String defaultFlag;

    private String title;

    @NotEmpty
    private String userName;

    private String phone;

    private String mobile;

    private String newZipcode;

    @NotEmpty
    private String zipcode;

    @NotEmpty
    private String address;

    @NotEmpty
    private String addressDetail;
}
