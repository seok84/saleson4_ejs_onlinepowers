package saleson.domains.mypage.application.dto.benefit;

import java.util.List;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter @Builder
public class GradeResponse {

    private String userLevel;

    private List<UserLevelResponse> list;

}
