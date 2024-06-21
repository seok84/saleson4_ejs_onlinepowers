package saleson.domains.display.application.dto;


import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DisplayImageResponse {
    private String image;
    private String url;
    private String content;
    private String color;
}

