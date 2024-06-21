package saleson.domains.mypage.application.dto.benefit;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class PointResponse {

    private int pointId;
    
    private String pointType;
    
    private int point;

    private int savedPoint;

    private String reason;

    private String expirationDate;

    private String createdDate;
}
