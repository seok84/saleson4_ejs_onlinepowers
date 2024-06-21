package saleson.domains.category.application.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class ItemEarnPointResponse {
    private int point;
    private float pointRate;
    private int levelPoint;
    private float levelPointRate;
    private String levelName;
}
