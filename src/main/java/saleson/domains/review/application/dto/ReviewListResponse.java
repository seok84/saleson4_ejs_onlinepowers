package saleson.domains.review.application.dto;


import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ReviewListResponse {

    private ReviewPageResponse reviewPageResponse;
    List<ReviewFilterResponse> reviewFilterResponses;

}
