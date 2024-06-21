package saleson.domains.display.application.dto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DisplayReviewListResponse {
    private List<DisplayReviewResponse> list;
}
