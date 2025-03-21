package kr.or.batirplan.security.vo;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

@Data
public class CustomUser extends User{
	
	private MemberVO memberVO;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO member) {
	    super(member.getMberId(), member.getMberPassword(),
	        member.getAuths().stream()
	            .map(authVO -> new SimpleGrantedAuthority(authVO.getMberAuthor()))
	            .collect(Collectors.toList()));
	    this.memberVO = member;
	}
	
	
}
