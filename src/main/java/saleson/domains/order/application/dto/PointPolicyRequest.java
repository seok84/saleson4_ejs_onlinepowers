package saleson.domains.order.application.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PointPolicyRequest {

    private String pointType;

    private float point;
}
