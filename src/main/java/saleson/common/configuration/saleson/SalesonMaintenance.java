package saleson.common.configuration.saleson;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.ObjectUtils;

import java.time.LocalDateTime;

@Slf4j
@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "saleson.maintenance")
public class SalesonMaintenance {

    private boolean enabled;
    private SalesonMaintenanceDateTime begin;
    private SalesonMaintenanceDateTime end;

    public boolean isMaintenance() {

        if (isEnabled()) {
            LocalDateTime now = LocalDateTime.now();
            LocalDateTime begin = getBegin().getDateTime();
            LocalDateTime end  = getEnd().getDateTime();

            if (!ObjectUtils.isEmpty(begin) && !ObjectUtils.isEmpty(end)) {
                return now.isAfter(begin) && (now.isBefore(end) || now.isEqual(end));
            }
        }

        return false;
    }
}


