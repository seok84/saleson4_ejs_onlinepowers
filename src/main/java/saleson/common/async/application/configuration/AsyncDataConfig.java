package saleson.common.async.application.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Configuration
public class AsyncDataConfig {

    @Bean
    public ExecutorService asyncDataExecutorServicePool() {
        return Executors.newWorkStealingPool();
    }

}
