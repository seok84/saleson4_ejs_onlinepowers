package saleson.domains.category.application.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class CardBenefitsResponse {
    private int benefitsId;
    private String subject;
    private String content;
    private String startDate;
    private String endDate;
    private String createdDate;
}
