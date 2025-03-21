package kr.or.batirplan.security.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import kr.or.batirplan.security.mapper.SecurityMapper;
import kr.or.batirplan.security.vo.CustomUser;
import kr.or.batirplan.security.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private SecurityMapper mapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.info("[CustomUserDetailsService]###Spring Security 인증 시도###");
        log.info("[CustomUserDetailsService]###Spring Security 인증 시도### username >>> " + username);

        Map<String, String> param = new HashMap<>();
        param.put("username", username);
        param.put("type", username.startsWith("C") ? "ccpy" : "empl");
        MemberVO member = mapper.readByUserInfo(param);
    	return member == null? null : new CustomUser(member);
    }
}
