package saleson.domains.item.application.dto;

import lombok.*;
import org.springframework.util.ObjectUtils;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
public class CombineOption {
    private int step;
    private Set<String> names;

    public CombineOption(int step) {
        this.step = step;
    }

    public void addName(String name){

        if (!ObjectUtils.isEmpty(name)) {
            Set<String> names = getNames();

            if (ObjectUtils.isEmpty(names)) {
                names = new LinkedHashSet<>();
            }

            names.add(name);

            setNames(names);
        }
    }
}
