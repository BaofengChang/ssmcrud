package com.changbaofeng.crud.test;

import com.changbaofeng.crud.dao.DepartmentMapper;
import com.changbaofeng.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 测试dao层工作
 */
//测试dao层工作
//推荐使用spring项目可以使用spring的单元测试，可以自动注入我们需要的组件
//首先，导入springtest的单元测试
//然后，使用@ContextConfiguration指定spring配置文件的位置
//直接 auto write 要使用的组件即可
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
//@ContextConfiguration("/applicationContext.xml")
public class MapperTest {
    /**
     * 测试部门 DepartmentMapper
     */
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    /**
     * 测试department
     */
    @Test
    public void testCRUD() {
//        //创建springioc容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//        //从容器中获取mapper
//        ioc.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);
//        插入几个部门

//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
//        departmentMapper.deleteByPrimaryKey(6);
//        生成员工数据，测试员工如诉
//        employeeMapper.insertSelective(new Employee(null,"张伟峰","M","1.@qq.com",1));
//    批量插入多个员工，可以一个一个加，也可以使用批量操作的sqlSession
//        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
//        for(int i=0;i<1000;i++){
//            String uuid = UUID.randomUUID().toString().substring(0,5)+i;
//            mapper.insertSelective(new Employee(null,uuid,"M",uuid+"@qq.com",1));
//        }
//        System.out.println("批量完成");
    }
}
