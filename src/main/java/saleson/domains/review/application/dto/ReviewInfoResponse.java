package saleson.domains.review.application.dto;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ReviewInfoResponse {
    private int pointReview;
    private int photoPointReview;
    private List<ReviewFilterResponse> reviewFilters;
}
