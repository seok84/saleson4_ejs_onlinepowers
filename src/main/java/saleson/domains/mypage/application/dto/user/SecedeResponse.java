package saleson.domains.mypage.application.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SecedeResponse {
    private long userId;
    private String loginId;
    private int point;
    private boolean snsFlag;





}
