package saleson.domains.brand.api.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BrandResponse {
    private int id;
    private String name;
    private String image;
    private String content;
}
