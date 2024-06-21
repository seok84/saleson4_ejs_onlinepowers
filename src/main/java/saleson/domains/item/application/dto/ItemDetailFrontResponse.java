package saleson.domains.item.application.dto;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.domains.category.application.dto.BreadcrumbResponse;
import saleson.domains.category.application.dto.CardBenefitsResponse;
import saleson.domains.category.application.dto.ItemEarnPointResponse;
import saleson.domains.review.application.dto.ReviewFilterResponse;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ItemDetailFrontResponse {
    private ItemDetailResponse item;
    private ItemEarnPointResponse itemEarnPoint;
    private CardBenefitsResponse cardBenefits;
    private List<ReviewFilterResponse> reviewFilters;
    private List<BreadcrumbResponse> breadcrumbs;
    private String deliveryInfo;
}
