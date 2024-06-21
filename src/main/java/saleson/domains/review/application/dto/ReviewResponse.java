package saleson.domains.review.application.dto;

import java.util.List;
import java.util.Map;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ReviewResponse {

    private int itemReviewId;

    private int itemId;

    private String itemUserCode;

    private String itemName;

    private String itemImageSrc;

    private String subject;

    private String content;

    private int score;

    private List<String> images;

    private String thumbnailSrc;

    private String createdDate;
    private String maskUsername;

    private boolean displayOptionsFlag;
    private String options;
    private String adminComment;

    private int likeCount = 0;

    private List<Map<String, Object>> filters;

    private boolean reportFlag;
    private boolean blockFlag;
    private boolean writtenMeFlag;


}
