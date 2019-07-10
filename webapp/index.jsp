<%--
  Created by IntelliJ IDEA.
  User: changbaofeng
  Date: 2019/3/31
  Time: 21:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());//拿到项目路径
    %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%--web路径
    不以/开始的相对路径，找资源以当前资源的路径为基准，经常容易出问题
    以/开始的相对路径，找资源，以服务器的路径为基准(http：//localhost:3306);需要加上项目名，即为http://localhost:3306/crud
    --%>
    <script src="${APP_PATH}/static/jquery-3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工新建Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">

                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="zhangweifeng@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--                            部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--员工修改--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">

                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="zhangweifeng@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--                            部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id = "emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--        显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th> <input type="checkbox" id="checkAll"></th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <%--        显示分页信息--%>
    <div class="row">
        <%--        分页文字信息--%>
        <div class="col-md-6" id="page_info">

        </div>
        <%--    分页条--%>
        <div class="col-md-6" id="page_nav">

        </div>
    </div>
</div>
<script>
    var totalRecords; //总记录数
    var pageNum; //当前页面

    //页面加载完成，直接发送一个ajax请求，要到分页页面
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                console.log(result);
                //    解析并显示员工数据
                build_emps_table(result);
                //    解析并显示分页数据
                build_page_info(result);
                //    解析显示分页条
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空table表
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;//员工数剧
        $.each(emps, function (index, item) {
            var checkBoxtTd = $("<td></td>").append("<input type='checkbox' class='check_item'/>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            /**
             *   <button class="btn btn-primary btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
             </button>
             <button class="btn btn-danger btn-sm">
             <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
             </button>
             * */
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加自定义属性，id
            editBtn.attr("edit_id",item.empId);
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash ")).append("删除");
            deleteBtn.attr("delete_id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            $("<tr></tr>").append(checkBoxtTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }

    //接卸显示分页信息
    function build_page_info(result) {
        $("#page_info").empty();

        $("#page_info").append(" 当前" + result.extend.pageInfo.pageNum + "页，总" + result.extend.pageInfo.pages + "页，总共" + result.extend.pageInfo.total + "条记录");
        totalRecords = result.extend.pageInfo.total;
        pageNum = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条,要有动作
    function build_page_nav(result) {
        //页面刷新
        $("#page_nav").empty();

        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePage.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePage.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPage.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPage.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }


        ul.append(firstPageLi).append(prePage);//首页，上一页
        //添加页码
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active")
            }
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        })
        ul.append(nextPage).append(lastPageLi);//下一页，末页

        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav");
    }

    function reset_form(ele) {
        // 清空表单
        $(ele)[0].reset();
        // 清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    // 点击新增按钮
    $("#emp_add_modal_btn").click(function () {
        //清空表单
        reset_form("#empAddModal form");
        // $("#empAddModal form")[0].reset();
        //发送ajax请求，查出部门信息，显示在下拉列表
        getDepts("#dept_add_select");
        // 弹出模态框
        $('#empAddModal').modal({
            backdrop: 'static'
        })
    });

    //查出所有部门信息
    function getDepts(ele) {
        //清空下拉列表值
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                // console.log(result);
                // 显示部门信息在下拉列表
                $.each(result.extend.depts, function (index, item) {
                    var optionEle = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                    optionEle.appendTo(ele);
                })

            }
        })
    }

    //校验表单数据
    function validate_add_form() {
        //拿到要校验的数据，使用正则表达式
        //校验姓名
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            // alert("用户名可以使2-5位中文或者6-16位英文和数字的组合")
            show_validate_msg("#empName_add_input", "error", "用户名可以使2-5位中文或者6-16位英文和数字的组合");

            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "")

        }
        // 校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("");
        }
        return true;
    }

    // 显示校验结果
    function show_validate_msg(ele, status, msg) {
        // 清除当前元素的状态
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    $("#empName_add_input").change(function () {
        // 发送ajax请求，校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkUser",
            data: "empName=" + empName,
            type: "post",
            success: function (result) {
                console.log(result);
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用")
                    $("#emp_save_btn").attr("ajax_va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg)
                    $("#emp_save_btn").attr("ajax_va", "error");
                }
            }
        })
    })

    // 保存按钮单击事件，保存员工
    $("#emp_save_btn").click(function () {
        // 表单数据提交给服务器进行保存
        //先对表单进行校验
        if (!validate_add_form()) {
            return false;
        }
        if ($(this).attr("ajax_va") == "error") {
            return false;
        }
        //发送ajax请求保存员工
        // alert($("#empAddModal form").serialize());
        $.ajax({
            url: "${APP_PATH}/emp/",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                // alert(result.msg);
                if (result.code == 100) {
                    $("#empAddModal").modal('hide');
                    to_page(totalRecords);
                } else {
                    // console.log(result);
                    if (undefined != result.extend.errorFields.email) {
                        //    显示邮箱的错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        //    显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName)
                    }
                    if (result.extend.errorFields.email) ;
                }

            }
        });
    });
    //1 按钮创建之前就绑定了，所以不行
    // 1) 可以创建按钮直接绑定
    // 2）绑定点击，live（）；jquery新版中删除了live方法，可以用on替代
    // $(".edit_btn").click(function () {
    //     alert("button");
    // })
    $(document).on("click", ".edit_btn", function () {
        // alert("edit");
        // 显示员工信息
        // 查出部门信息，并显示部门列表
        //发送ajax请求，查出部门信息，显示在下拉列表
        getDepts("#dept_update_select");
        //发送ajax请求，查的员工信息
        getEmp($(this).attr("edit_id"));
        //把员工id传递模态框更新按钮
        $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
        // 弹出模态框
        $('#empUpdateModal').modal({
            backdrop: 'static'
        })
    });
    //查出员工信息
    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emps/"+id,
            type:"GET",
            success:function (result) {
                // console.log(result);
                //显示员工数据
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);//对静态文本，就用text
                $("#email_update_input").val(empData.email);//对输入框就用val（）赋值
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        })
    }
    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
    //    发送ajax请求，保存更新信息
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
            type:"put",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //关闭对话框
                $("#empUpdateModal").modal("hide");
                //回到本页面
                to_page(pageNum);
            }
        })
    })
    $(document).on("click", ".delete_btn", function () {
        var empName = $(this).parents("tr").find("td:eq(1)").text();
        var empId = $(this).attr("delete_id");
        if (confirm("确认删除【"+empName+"】吗？")) {
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    // console.log(result.);
                    alert(result.msg)
                    to_page(pageNum);
                }
            })
        }
    });
    //全选、全不选功能
    $("#checkAll").click(function () {
        //attr获取checked是undefined,这些原生的属性，推荐使用prop修改和读取dom原生，attr获取自定义
        // alert($(this).prop("checked"));
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    $(document).on("click", ".check_item", function () {
        //判断当前选中的元素是不是五个
        var status = $(".check_item:checked").length==$(".check_item").length;
        $("#checkAll").prop("checked",status);
    });
    //全部删除
    $("#emp_delete_all_btn").click(function () {
        var ids = "";
        var names = "";
        $.each($(".check_item:checked"),function () {
            var name = $(this).parents("tr").find("td:eq(2)").text();
            names = names+","+name;
            var id = $(this).parents("tr").find("td:eq(1)").text();
            ids = ids+"-"+id;
        });
        if(confirm("确认删除【"+names.substring(1)+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/emp/"+ids.substring(1),
                type:"DELETE",
                success:function (result) {
                    // console.log(result.);
                    alert(result.msg)
                    to_page(pageNum);
                }
            })
        }
    })
</script>

</body>
</html>
