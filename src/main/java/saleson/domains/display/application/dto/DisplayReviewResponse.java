package saleson.domains.display.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DisplayReviewResponse {
    private String itemUserCode;
    private String itemName;
    private String content;
    private int score;
    private String image;

}
