package saleson.common.configuration.saleson;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "saleson.social")
public class SalesonSocialConfig {

    private SalesonSocialAppleConfig apple;
    private SalesonSocialNaverConfig naver;
    private SalesonSocialKakaoConfig kakao;

}
