package com.changbaofeng.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @program: ssmcrud
 * @description: 通用的返回的类
 * @author: Chang Baofeng
 * @create: 2019-05-13 21:03
 **/

public class Msg {
    //state code 100-成功 ，200-失败
    private int code;
    // 提示信息
    private String msg;
    //用户要返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<String, Object>();

    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }
    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }

    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }
}
