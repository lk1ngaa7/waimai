<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<!-- ————————————————————————添加窗口———————————————————————————————— -->
<div id="seeFoodWindow" class="easyui-window" title="添加菜品"
	data-options="iconCls:'icon-see',resizable:false,draggable:true,modal:true"
	style="width: 460px; height: 335px;">
	<!-- 这个是ajax表单 -->
	<div style="margin:17px; font-size: 14px">
	<form class="form" id="seeFoodForm" method="post" action="">
		<table align="center">
			<tbody>
				<tr>
					<td class="alignRight">店 铺：</td>
					<td>
                        <input type="text" id="placeName1" style="width: 220px">
                        <input type="hidden" id="placeId1" name="pid">
					</td>
				</tr>

				<tr>
					<td class="alignRight">菜 名：</td>
					<td><input type="text" class="easyui-validatebox"
						data-options="required:true" id="foodName1" name="name" style="width: 220px;"></td>
				</tr>

				<tr>
					<td class="alignRight">价 格：</td>
					<td><input type="text" name="price" style="width: 220px;"></td>
				</tr>

				<tr>
					<td class="alignRight">描述：</td>
					<td>
                        <textarea rows="3" cols="12" name="description" style="width: 220px; height: 100px"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<div style="text-align: center; pseeing: 5px">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="submitAddFood();">提交</a> &nbsp;&nbsp; <a
				href="javascript:void(0)" class="easyui-linkbutton"
				onclick="clearFoodForm();">清除</a> &nbsp;&nbsp; <a
				href="javascript:void(0)" class="easyui-linkbutton"
				onclick="closeAddFoodWindow();">取消</a>
		</div>
			<input type="hidden" name="fid">
		</form>
	</div>
</div>


<script type="text/javascript">
	//将表单内容重置为空
	function clearFoodForm() {
		$('#seeFoodForm').form('clear');
	}

	function closeAddFoodWindow() {
		$("#seeFoodWindow").window("close");
		clearFoodForm();
	}

	//提交表单（ajax方式）
	function submitAddFood() {
		var str = "";
		if ($("#seeFoodForm input[name='fid']").val() == "") {
			str = "添加";
		} else {
			str = "更改";
		}
		$('#seeFoodForm').form('submit', {
			url : "/admin/food/see",
			onSubmit : function() {
			},
			success : function(data) {
				if (data == true || data == "true" || data == "1" || data) {
					showMyMsgDialog(5000,str + '成功！（'+$("#foodName1").val()+'）');
					$("#foodList").datagrid("reload");
					$("#seeFoodWindow").window("close");
				} else {
					$.messager.alert("提示", str + '失败！');
				}
			}
		});
	}

	//默认加载进去后关闭一系列窗口
	$(function() {
		//初始化添加菜品窗口并关闭
		$("#seeFoodWindow").window({
			onClose : function() {
				clearFoodForm();
			}
		});
		$("#seeFoodWindow").window("close");
	});
</script>
<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
<!-- ————————————————————————添加窗口结束———————————————————————————————— -->
