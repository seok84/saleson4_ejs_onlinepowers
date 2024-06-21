package saleson.domains.qna.application.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QnaResponse {
    private int id;
    private String label;
    private String qnaType;
    private String subject;
    private String question;
    private List<String> files;
    private boolean answerFlag;
    private QnaAnswerResponse answer;

    private boolean secretFlag;
    private String userName;

    private String date;

    private boolean reportFlag;
    private boolean blockFlag;
    private boolean writtenMeFlag;
}
