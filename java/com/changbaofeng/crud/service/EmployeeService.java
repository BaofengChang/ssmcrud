package com.changbaofeng.crud.service;

import com.changbaofeng.crud.bean.Employee;
import com.changbaofeng.crud.bean.EmployeeExample;
import com.changbaofeng.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    //注入EmployeeMapper
    @Autowired
    EmployeeMapper employeeMapper;

    /*
    * 查询所有员工
    * */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 查询员工
     */

    /**
     * 保存员工
     * @param employee
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }


    //检验员工名是否可用
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        Long count=employeeMapper.countByExample(example);
        return count==0;
    }

    /**
     * 按照id查询员工
     * @param id
     * @return
     */

    public Employee getEmp(Integer id) {
        Employee employee=employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 员工更新
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 员工删除
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample employeeExample  = new EmployeeExample();
        EmployeeExample.Criteria criteria =  employeeExample.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample);
    }
}
