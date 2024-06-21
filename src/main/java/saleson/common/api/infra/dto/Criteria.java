package saleson.common.api.infra.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Criteria {

    private int size = 10;
    private int page = 1;
    private String where;
    private String query;
    private String sort;
    private String orderBy;

}
