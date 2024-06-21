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
public class PromotionResponse {
    private List<DisplayImageResponse> promotion;
    private List<DisplayImageResponse> mobilePromotion;

    public List<String> getPromotionItemList() {
        List<String> list = new ArrayList<>();

        try {
            if (!ObjectUtils.isEmpty(getPromotion())) {
                getPromotion().stream()
                        .filter(i -> !ObjectUtils.isEmpty(i.getImage()))
                        .forEach(i -> {
                            list.add(i.getImage());
                        });
            }

            if (!ObjectUtils.isEmpty(getMobilePromotion())) {
                getMobilePromotion().stream()
                        .filter(i -> !ObjectUtils.isEmpty(i.getImage()))
                        .forEach(i -> {
                            list.add(i.getImage());
                        });
            }
        } catch (Exception e) {}

        return list;
    }
}
