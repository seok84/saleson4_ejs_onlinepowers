package saleson.domains.common.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AboutUsResponse {
    private String shopName;
    private String companyName;
    private String companyNumber;
    private String bossName;
    private String categoryType;
    private String businessType;
    private String telNumber;
    private String faxNumber;
    private String counselTelNumber;
    private String adminTelNumber;
    private String adminName;
    private String email;
    private String adminEmail;
    private String post;
    private String address;
    private String addressDetail;
    private String mailOrderNumber;
}
