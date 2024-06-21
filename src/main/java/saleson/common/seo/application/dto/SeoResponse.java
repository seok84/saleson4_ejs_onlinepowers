package saleson.common.seo.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SeoResponse {
    
    private String title;

    private String keywords;

    private String description;

    private boolean indexFlag;

    private OpenGraphResponse openGraph;
}
