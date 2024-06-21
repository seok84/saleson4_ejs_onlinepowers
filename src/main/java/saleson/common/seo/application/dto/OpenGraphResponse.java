package saleson.common.seo.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OpenGraphResponse {

    private String link;

    private String title;

    private String type;

    private String image;

    private String description;

    private String url;

}
