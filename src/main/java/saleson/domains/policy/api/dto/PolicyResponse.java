package saleson.domains.policy.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PolicyResponse {
    private int policyId;
    private String policyType;
    private String content;
    private String title;
    private String exhibitionStatus;
}
