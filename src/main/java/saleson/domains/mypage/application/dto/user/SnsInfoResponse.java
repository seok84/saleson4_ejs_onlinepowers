package saleson.domains.mypage.application.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SnsInfoResponse {
   private String snsType;
   private int snsUserId;
   private String createdDate;


}
