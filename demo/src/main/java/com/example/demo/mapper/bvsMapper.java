package com.example.demo.mapper;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.jwt.RefreshToken;
import com.example.demo.security.MyUserDetails;
import com.example.demo.vo.USER_VO;


@Mapper
public interface bvsMapper {
    List<USER_VO> getUserList();

    Optional<MyUserDetails> findByUserId(String USER_ID);

	Optional<USER_VO> findByUser(String username);
	
	void insertRefreshToken(USER_VO refreshToken);
	
	USER_VO findUserByRefreshToken(String TOEKN);
	
	List<Map<String,Object>> selectFrontMenuList(Map<String, Object> params) throws Exception;

	Map<String, Object> selectSnbMenuInfoByMenuId(Map<String, Object> params) throws Exception;

	List<Map<String,Object>> selectSiteMainConfig(Map<String, Object> params) throws Exception;

	List<Map<String,Object>> selectSiteMainMenuData(Map<String, Object> params) throws Exception;

	Map<String, Object> selectBoardConfInfo(Map<String, Object> params) throws Exception;

	List<Map<String,Object>> selectSiteMainBbsNoticeItemList(Map<String, Object> params) throws Exception;

	List<Map<String,Object>> selectSiteMainRandomBbsItemList(Map<String, Object> params) throws Exception;

	List<Map<String,Object>> selectSiteMainConfigSubList(Map<String, Object> params) throws Exception;

	List<Map<String,Object>> selectSiteMainConfigSubItemList(Map<String, Object> params) throws Exception;

	Map<String, Object> selectFooterInfo(Map<String, Object> params) throws Exception;

	List<Map<String,Object>> selectFooterLinkGroupList(Map<String, Object> params) throws Exception;

	List<Map<String,Object>> selectFooterSiteList(Map<String, Object> params) throws Exception;
}
