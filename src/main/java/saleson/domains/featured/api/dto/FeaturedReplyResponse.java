package saleson.domains.featured.api.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FeaturedReplyResponse {

    private Long id;
    private String loginId;
    private String content;
    private String date;
    private boolean blockFlag;
    private boolean reportFlag;
    private boolean writtenMeFlag;

}
