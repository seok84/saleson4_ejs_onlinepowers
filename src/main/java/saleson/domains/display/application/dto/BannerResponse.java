package saleson.domains.display.application.dto;

import lombok.*;
import org.springframework.util.ObjectUtils;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BannerResponse {

    private List<DisplayImageResponse> middleBanner;
    private List<DisplayImageResponse> mobileMiddleBanner;
    private List<DisplayImageResponse> advertisement;
    private List<DisplayImageResponse> featured;

}
