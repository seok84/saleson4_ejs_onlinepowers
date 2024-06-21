package saleson.common.configuration.saleson;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
@Setter
public class SalesonMaintenanceDateTime {
    private String date;
    private String time;

    public LocalDateTime getDateTime() {
        try {
            return LocalDateTime.parse(getDate()+" "+getTime(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        } catch (Exception e) {
            return null;
        }
    }
}
