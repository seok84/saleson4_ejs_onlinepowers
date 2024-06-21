package saleson.domains.featured.api.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FeaturedReplyRequest {
   private int featuredId;
   private String replyContent;
}
