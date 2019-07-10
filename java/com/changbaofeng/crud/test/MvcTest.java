package com.changbaofeng.crud.test;

import com.changbaofeng.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
*使用Spring测试模块提供的测试请求功能，测试crud请求的正确性
 * Spring4的测试，需要servlet3.0的支持
* */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration //使得ioc可以装配自己
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})//加载配置文件
public class MvcTest {
    //传入springmvc的ioc
    @Autowired //只能自动装配，只能装配ioc容器的，
    WebApplicationContext context;
    //虚拟mvc请求，获取处理结果，mock翻译过来就是虚假的
    MockMvc mockMvc;
    @Before //每次使用的时候，都去初始化一下
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
//    编写测试分页的方法
    @Test
    public void testPage() throws Exception{
        //模拟请求（get，delet等等），拿到页面信息 。这里通过模拟get请求，拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","1")).andReturn();
        //请求成功后，请求域中会有pageInfo；可以取出pageInfo进行验证;
        MockHttpServletRequest request = result.getRequest();
        //pageInfo 首字母小写 ，尝试将pageInfo信息转换为pageinfo
        PageInfo pi = (PageInfo)request.getAttribute("pageInfo");
        System.out.println("当前页码："+pi.getPageNum());
        System.out.println("总页码"+pi.getPages());
        System.out.println("总记录数："+pi.getTotal());
        System.out.println("在页面需要显示的连续页码");
        int [] nums = pi.getNavigatepageNums();
        for(int i :nums){
            System.out.println(" "+i);
        }
        //获取员工数据
        List<Employee> list = pi.getList();
        for(Employee employee:list){
            System.out.println("ID:"+employee.getEmpId()+",Name:"+employee.getEmpName());
        }
    }
}
