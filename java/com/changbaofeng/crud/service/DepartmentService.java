package com.changbaofeng.crud.service;

import com.changbaofeng.crud.bean.Department;
import com.changbaofeng.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @program: ssmcrud
 * @description:
 * @author: Chang Baofeng
 * @create: 2019-07-04 16:40
 **/

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getDepts() {
        List<Department> list = departmentMapper.selectByExample(null);
        return  list;
    }
}
