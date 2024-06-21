package saleson.domains.policy.api.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class PolicyListResponse {

    private List<PolicyResponse> policies;

}
