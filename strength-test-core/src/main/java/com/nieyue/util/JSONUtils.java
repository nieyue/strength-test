package com.nieyue.util;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nieyue.bean.Account;
import com.nieyue.bean.Role;

import java.util.*;

/**
 * jackson工具类
 */
public class JSONUtils {
 
    private final static ObjectMapper objectMapper = new ObjectMapper();
 
    private JSONUtils() {
 
    }
 
    public static ObjectMapper getInstance() {
 
        return objectMapper;
    }
 
    /**
     * javaBean,list,array convert to json string
     */
    public static String obj2json(Object obj) throws Exception {
        return objectMapper.writeValueAsString(obj);
    }
 
    /**
     * json string convert to javaBean
     */
    public static <T> T json2pojo(String jsonStr, Class<T> clazz)
            throws Exception {
        return objectMapper.readValue(jsonStr, clazz);
    }
 
    /**
     * json string convert to map
     */
    public static <T> Map<String, Object> json2map(String jsonStr)
            throws Exception {
        return objectMapper.readValue(jsonStr, Map.class);
    }
 
    /**
     * json string convert to map with javaBean
     */
    public static <T> Map<String, T> json2map(String jsonStr, Class<T> clazz)
            throws Exception {
        Map<String, Map<String, Object>> map = objectMapper.readValue(jsonStr,
                new TypeReference<Map<String, T>>() {
                });
        Map<String, T> result = new HashMap<String, T>();
        for (Map.Entry<String, Map<String, Object>> entry : map.entrySet()) {
            result.put(entry.getKey(), map2pojo(entry.getValue(), clazz));
        }
        return result;
    }
 
    /**
     * json array string convert to list with javaBean
     */
    public static <T> List<T> json2list(String jsonArrayStr, Class<T> clazz)
            throws Exception {
        List<Map<String, Object>> list = objectMapper.readValue(jsonArrayStr,
                new TypeReference<List<T>>() {
                });
        List<T> result = new ArrayList<T>();
        for (Map<String, Object> map : list) {
            result.add(map2pojo(map, clazz));
        }
        return result;
    }
 
    /**
     * map convert to javaBean
     */
    public static <T> T map2pojo(Map map, Class<T> clazz) {
        return objectMapper.convertValue(map, clazz);
    }

    public static void main(String[] args) throws Exception {
        Account account = new Account();
        account.setAccountId(100000l);
        account.setNickname("sdf");
        account.setCreateDate(new Date());
        Role role=new Role();
        role.setName("管理员");
        role.setUpdateDate(new Date());
        account.setRole(role);
        String s = obj2json(account);
        System.out.println(s);
        Account pojo = json2pojo(s, Account.class);
        System.out.println(pojo);
        Map<String, Object> map = json2map(s);
        System.out.println(map);

    }
}
