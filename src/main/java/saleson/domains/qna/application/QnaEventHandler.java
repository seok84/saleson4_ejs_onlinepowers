package saleson.domains.qna.application;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import saleson.common.utils.FrontUtils;
import saleson.domains.qna.application.dto.ItemQnaPageResponse;
import saleson.domains.qna.application.dto.QnaPageResponse;
import saleson.domains.qna.application.dto.QnaResponse;

@Component
@RequiredArgsConstructor
@Slf4j
public class QnaEventHandler {

    public <T extends QnaResponse>void setConvertHtml(T t) {
        t.setQuestion(FrontUtils.nl2br(t.getQuestion()));

        if (!ObjectUtils.isEmpty(t.getAnswer())) {
            t.getAnswer().setAnswer(FrontUtils.nl2br(t.getAnswer().getAnswer()));
        }
    }

    public void setConvertHtml(ItemQnaPageResponse response) {
        if (!ObjectUtils.isEmpty(response) && !ObjectUtils.isEmpty(response.getContent())) {
            response.getContent().forEach(c->{
                setConvertHtml(c);
            });
        }
    }

    public void setConvertHtml(QnaPageResponse response) {
        if (!ObjectUtils.isEmpty(response) && !ObjectUtils.isEmpty(response.getContent())) {
            response.getContent().forEach(c->{
                setConvertHtml(c);
            });
        }
    }
}
