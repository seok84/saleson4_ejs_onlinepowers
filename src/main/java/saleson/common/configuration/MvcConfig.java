package saleson.common.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.resource.EncodedResourceResolver;
import org.springframework.web.servlet.resource.PathResourceResolver;
import org.springframework.web.servlet.view.JstlView;
import saleson.common.interceptor.FrontHandlerInterceptor;
import saleson.common.view.FrontViewResolver;

@Configuration
@EnableWebMvc
public class MvcConfig implements WebMvcConfigurer {

    @Value("${resource.storage.location}")
    private String storageResourceLocation;

    @Bean
    public ViewResolver viewResolver() {
        final FrontViewResolver bean = new FrontViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/views/");
        bean.setSuffix(".jsp");
        return bean;
    }

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.viewResolver(viewResolver());
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        registry
                .addResourceHandler(
                        "/static/**",
                        "robots.txt",
                        "favicon.ico"
                )
                .addResourceLocations("classpath:/static/")
                .setCachePeriod(3600)
                .setUseLastModified(true)
                .resourceChain(true)
                .addResolver(new EncodedResourceResolver())
                .addResolver(new PathResourceResolver());

        registry.addResourceHandler("/upload/**")
                .addResourceLocations(storageResourceLocation + "/upload/")
                .setCachePeriod(3600)
                .setUseLastModified(true)
                .resourceChain(true)
                .addResolver(new EncodedResourceResolver())
                .addResolver(new PathResourceResolver());
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        String[] excludePath = new String[]{"/static/**", "/upload","robots.txt"};

        registry.addInterceptor(frontHandlerInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns(excludePath);

    }

    @Bean
    public FrontHandlerInterceptor frontHandlerInterceptor() {
        return new FrontHandlerInterceptor();
    }
}
