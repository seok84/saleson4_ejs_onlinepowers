package saleson.domains.mypage.application.dto.info;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LatelyItemCriteria {

private String ids;

private int limit = 24;
}
