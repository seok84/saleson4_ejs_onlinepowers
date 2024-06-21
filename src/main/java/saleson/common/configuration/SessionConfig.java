package saleson.common.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.session.MapSessionRepository;
import org.springframework.session.config.annotation.web.http.EnableSpringHttpSession;
import org.springframework.session.web.http.CookieSerializer;
import org.springframework.session.web.http.DefaultCookieSerializer;

import java.util.concurrent.ConcurrentHashMap;

@EnableSpringHttpSession
@Configuration
public class SessionConfig {



    @Bean
    public MapSessionRepository sessionRepository() {
        return new MapSessionRepository(new ConcurrentHashMap<>());
    }

    @Bean
    public CookieSerializer cookieSerializer() {
        DefaultCookieSerializer serializer = new DefaultCookieSerializer();

        serializer.setCookieName("FRONT_SALESONID");
        // https 미오픈으로 인한 임시 주석
//        serializer.setUseSecureCookie(true);
//        serializer.setSameSite("None");
        serializer.setSameSite("Lax");
        serializer.setCookiePath("/");
        serializer.setUseHttpOnlyCookie(true);

        return serializer;
    }


}
