package saleson.common.analytics.firebase.configuration;


import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "firebase")
public class FirebaseConfig {

    private boolean enabled;
    private Config config;
}
