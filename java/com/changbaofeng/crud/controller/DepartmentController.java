package com.changbaofeng.crud.controller;

import com.changbaofeng.crud.bean.Department;
import com.changbaofeng.crud.bean.Msg;
import com.changbaofeng.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @program: ssmcrud
 * @description: 处理和部门有关的请求
 * @author: Chang Baofeng
 * @create: 2019-07-04 16:39
 **/

@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有的部门信息
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts",list);
    }
}
