package saleson.domains.mypage.application.dto.info;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class OrderClaimImageResponse {

    private long orderClaimImageId;

    private String claimImage;

    private String claimCode;

    private int ordering;

    private String createdDate;

    private String defaultSrc;

    private String imageSrc;
}
