package com.example.demo.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Builder;
import lombok.Data;

@Data@Builder
public class MyUserDetails implements UserDetails {

	private static final long serialVersionUID = -7186201901147610757L;

	private Long id;

	private String USER_ID;
 	private String PWD;
 	private final Collection<SimpleGrantedAuthority> role;
 	
 	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
 		return role;
	}

    @Override
    public String getUsername() {
        return USER_ID;
    }
    
    @Override
    public String getPassword() {
    	return PWD;
    }
    
	@Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }


}
