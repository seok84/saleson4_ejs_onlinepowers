package saleson.domains.mypage.application.dto.user;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SnsInfoListResponse {

    private List<SnsInfoResponse> list;
    private boolean SnsFlag;


}
