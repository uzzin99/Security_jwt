package com.example.demo.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.jwt.JwtToken;
import com.example.demo.jwt.JwtTokenProvider;
import com.example.demo.mapper.bvsMapper;
import com.example.demo.security.MyUserDetails;
import com.example.demo.vo.USER_VO;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/mainApi")
@RequiredArgsConstructor
public class MainApiController {
	private final PasswordEncoder passwordEncoder;
	private final JwtTokenProvider jwtTokenProvider;

	@Autowired private bvsMapper mapper;

	@GetMapping("/menu")
    public Map<String, Object> getMenuInfo() throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("SITE_GROUP_NO", "5");
        params.put("SITE_NO", "58");

        List<Map<String, Object>> siteMenu = mapper.selectFrontMenuList(params);
        LinkedHashMap<String, Map<String, Object>> linkMap = new LinkedHashMap<>();

        for (int idx = 0; idx < siteMenu.size(); idx++) {
            @SuppressWarnings("unchecked")
            Map<String, Object> menu = (Map<String, Object>) ((HashMap<String, Object>) siteMenu.get(idx)).clone();
            linkMap.put(String.valueOf(menu.get("MENU_NO")), menu);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("MENU_NO", "ROOT");
        result.put("SUB", new ArrayList<Map<String, Object>>());

        for (Map<String, Object> menu : linkMap.values()) {
            String P_MENU_NO = menu.get("P_MENU_NO") == null ? "" : String.valueOf(menu.get("P_MENU_NO"));

            if ("1".equals(String.valueOf(menu.get("MENU_LVL")))) {
                @SuppressWarnings("unchecked")
                ArrayList<Map<String, Object>> child = (ArrayList<Map<String, Object>>) result.get("SUB");
                child.add(menu);
            } else {
                Map<String, Object> parentMenu = new HashMap<>();
                parentMenu = linkMap.get(P_MENU_NO);
                if (parentMenu == null) continue;
                if (!parentMenu.containsKey("SUB")) parentMenu.put("SUB", new ArrayList<Map<String, Object>>());
                @SuppressWarnings("unchecked")
                ArrayList<Map<String, Object>> child2 = (ArrayList<Map<String, Object>>) parentMenu.get("SUB");
                child2.add(menu);
            }
        }

        return result;
    }
	
	@GetMapping("/getMainItem")
    public Map<String, Object> getMainItem(HttpServletRequest request) throws Exception {
		String tempCd = "IPSI_A";
		String siteNo = "58";

        Map<String, Object> mainPar = new HashMap<String, Object>();
        mainPar.put("TEMP_CODE", tempCd);
        mainPar.put("SITE_NO", siteNo);
        //메인화면 구성요소 조회
        List<Map<String,Object>> configList = mapper.selectSiteMainConfig(mainPar);

        Map<String, Object> result = new HashMap<>();

        for(int i=0; i<configList.size(); i++){
            Map<String,Object> configPK = configList.get(i);
            result.put("mainConfig"+configPK.get("CONFIG_CD")+"_"+configPK.get("CONFIG_SEQ"), configPK);

            mainPar.put("CONFIG_CD", configPK.get("CONFIG_CD"));
            mainPar.put("CONFIG_SEQ", configPK.get("CONFIG_SEQ"));
            if("C1406".equals(configPK.get("CONFIG_CD"))){
                List<Map<String,Object>> subList = mapper.selectSiteMainMenuData(mainPar);
                if(subList != null){
                    List<Map<String,Object>> bbsItems = new ArrayList<Map<String, Object>>();
                    Map<String, Object> randomPar = new HashMap<String, Object>();
                    for(int j=0; j<subList.size(); j++){
                    	
                        int bbsCnt=4;

                        if("IPSI_A".equals(configPK.get("TEMP_CODE"))){
                            if("2".equals(String.valueOf(configPK.get("CONFIG_SEQ")))){
                                bbsCnt=4;
                            }else{
                                bbsCnt=5;
                            }
                        }

                        randomPar.put("BBS_CNT", bbsCnt);
                        randomPar.put("TEMP_CODE", subList.get(j).get("TEMP_CODE"));
                        randomPar.put("BASE_SITE_NO", subList.get(j).get("SITE_NO"));
                        randomPar.put("CONFIG_CD", subList.get(j).get("CONFIG_CD"));
                        randomPar.put("CONFIG_SEQ", subList.get(j).get("CONFIG_SEQ"));
                        randomPar.put("SUB_SEQ", subList.get(j).get("SUB_SEQ"));
                        randomPar.put("SITE_NO", subList.get(j).get("BOARDSITE_NO"));
                        randomPar.put("MENU_NO", subList.get(j).get("BOARD_CD"));
                        randomPar.put("CONTENTS_NO", subList.get(j).get("BOARD_CATEGORY_NO"));
                        randomPar.put("USE_NOTICE_YN", null);
                        Map<String, Object> sub = new HashMap<String, Object>();
                        if("IPSI_A".equals(configPK.get("TEMP_CODE"))){
                            if("1".equals(String.valueOf(configPK.get("CONFIG_SEQ")))){
                                //입학홈페이지의 공지사항게시판 연결일 경우 상단공지 가져옴
                                Map<String, Object> boardConf = mapper.selectBoardConfInfo(randomPar);
                                String NOTICE_LIMIT = boardConf.get("USE_NOTICE_YN") == null ? "0" : boardConf.get("NOTICE_LIMIT") == null ? "0" : String.valueOf(boardConf.get("NOTICE_LIMIT"));
                                String USE_NOTICE_YN = String.valueOf(boardConf.get("USE_NOTICE_YN"));
                                if(!"0".equals(NOTICE_LIMIT)){
                                    randomPar.put("NOTICE_LIMIT", NOTICE_LIMIT);
                                    randomPar.put("USE_NOTICE_YN", USE_NOTICE_YN);
                                    sub.put("SUB_TOP", mapper.selectSiteMainBbsNoticeItemList(randomPar));
                                }
                            }
                        }
                        sub.put("SUB", mapper.selectSiteMainRandomBbsItemList(randomPar));

                        bbsItems.add(sub);
                    }
                    result.put("bbsItems"+configPK.get("CONFIG_CD")+"_"+configPK.get("CONFIG_SEQ"), bbsItems);
                }
            }
            
            if("C1434".equals(configPK.get("CONFIG_CD"))){
				//학과 소개
            	result.put("deptItems"+configPK.get("CONFIG_CD")+"_"+configPK.get("CONFIG_SEQ"), mapper.selectSiteMainConfigSubItemList(mainPar));
			}
            
            result.put("mainConfig"+configPK.get("CONFIG_CD")+"_"+configPK.get("CONFIG_SEQ"), configPK);
            result.put("mainConfigSub"+configPK.get("CONFIG_CD")+"_"+configPK.get("CONFIG_SEQ"), mapper.selectSiteMainConfigSubList(mainPar));
        }

        return result;
	}
	
	@GetMapping("/getFooterItem")
    public Map<String, Object> getFooterInfo(HttpServletRequest request) throws Exception {
        Map<String, Object> params = new HashMap<>();
        Map<String, Object> result = new HashMap<>();
        
        params.put("BASIC_SEQ", 20);
        params.put("GBN", "C0901");

        // 푸터 가져오기
        Map<String, Object> footerInfo = mapper.selectFooterInfo(params);
        result.put("footerInfo",footerInfo);
        
        List<Map<String, Object>> footerLinkGroupInfo = mapper.selectFooterLinkGroupList(params);
        result.put("footerLinkGroupInfo",footerLinkGroupInfo);
        
        params.put("GBN", "C0901");
        List<Map<String, Object>> footerSiteInfo = mapper.selectFooterSiteList(params);
        result.put("footerSiteInfo",footerSiteInfo);
        
        params.put("GBN", "C0903");
        List<Map<String, Object>> footerSnsSiteInfo = mapper.selectFooterSiteList(params);
        result.put("footerSnsSiteInfo",footerSnsSiteInfo);

        return result;
    }
}
