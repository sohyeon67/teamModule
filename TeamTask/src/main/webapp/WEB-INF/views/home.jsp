<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>jsTree test</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
</head>
<body>
<div id="jstree">

</div>
<script>
$(function () {
	
	$.ajax({
		type:'post',
		url:'/treelist.do',
		dataType:'json',
		success: function(data) {
			console.log(data);
			 var academy = new Array();
             // 데이터 받아옴
		     $.each(data, function(idx, item){
		    	 academy[idx] = {id:item.id, parent:item.parentId, text:item.name};
		     });
			// 트리 생성
			$('#jstree').jstree({
				core: {
					data: academy
				},
				types: {
					'default': {
						'icon': 'jstree-folder'
					}
				},
			 	plugins: ['wholerow', 'types']
			})
			.bind('loaded.jstree', function(event, data){
				//트리 로딩 완료 이벤트
			})
			.bind('select_node.jstree', function(event, data){
				//노드 선택 이벤트
			})
		},
		error: function(data) {
			alert("에러");
		}
	});
	
});
</script>
</body>
</html>
