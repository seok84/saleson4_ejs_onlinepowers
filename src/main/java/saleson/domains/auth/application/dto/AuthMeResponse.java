package saleson.domains.auth.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AuthMeResponse {
    private String loginType;
    private String exclusiveMallUri;
    private Long userId;
    private String loginId;
    private String name;
    private String email;
    private String companyName;
    private boolean certificationFlag;//본인인증 여부
    private boolean tempPasswordFlag;//임시비밀번호 여부
    private boolean sleepUserFlag;//휴면회원 여부
    private boolean expiredPasswordFlag;//만료된 비밀번호 여부
}
