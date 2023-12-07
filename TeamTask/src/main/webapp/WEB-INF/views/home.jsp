<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>jsTree and Toast UI Grid Integration</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>
<body>
<!-- jstree가 생성될 곳 -->
<div id="jstree"></div>
<br />
<!-- grid가 생성될 곳 -->
<div id="grid-container"></div>
<script>
$(function() {
	var grid = null;
	
	// jstree 불러오기
	treelist();

	
	
	function treelist() {
		//트리 데이터 가져오기
		$.ajax({
			type : 'post',
			url : '/treelist.do',
			dataType : 'json',
			success : function(data) {
				console.log(data);
				var academy = new Array();
				// 데이터 받아옴
				$.each(data, function(idx, item) {
					academy[idx] = {
						id : item.id,
						parent : item.parentId,
						text : item.name
					};
				});
				// 트리 생성
				$('#jstree').jstree({
					core : {
						data : academy,
						check_callback : true
					},
					types : {
						'default' : {
							'icon' : 'jstree-folder'
						}
					},
					plugins : [ 'contextmenu' ]
				}).bind('loaded.jstree', function(event, data) {
					// 트리 로딩 완료 이벤트
				}).bind('select_node.jstree', function(event, data) {
					// 노드 선택 이벤트
					console.log("Selected Node:", data.node);
					console.log("Selected data:", data);
					console.log("이름 : ", data.node.text);

					// Toast UI Grid 생성 및 표시
					// grid 틀 생성
					createGrid();
					
					var clickData = {
						id: 1
					}
					
					getGridData(1);
				}).bind('create_node.jstree', function(event, data) {
					console.log("노드 생성 데이터 : ", data);
				}).bind('rename_node.jstree', function(event, data) {
					console.log("노드 변경 데이터 : ", data);
				}).bind('delete_node.jstree', function(event, data) {
					console.log("노드 삭제 데이터 : ", data);
				});
			},
			error : function(xhr, status, error) {
				console.error('AJAX 오류:', status, error);
			}
		}); //jstree 끝
	}
	
	
	// Grid 틀 생성
	function createGrid() {
		if(grid != null) {
			grid.destroy();
		}
		
		grid = new tui.Grid({
			el : document.getElementById('grid-container'),
			scrollX : false,
			scrollY : false,
			// name이 자바 변수이름과 같아야함
			columns : [ {
				header : '번호',
				name : 'stId'
			}, {
				header : '이름',
				name : 'stName'
			}, {
				header : '연락처',
				name : 'tel',
				editor : 'text'
			}, {
				header : '전공자 유무',
				name : 'majorType',
				formatter : 'listItemText',
				editor : {
					type : 'select',
					options : {
						listItems : [ {
							text : '전공자',
							value : '1'
						}, {
							text : '비전공자',
							value : '2'
						} ]
					}
				}
			}, {
				header : '자격증',
				name : 'certificate',
				formatter : 'listItemText',
				editor : {
					type : 'checkbox',
					options : {
						listItems : [ {
							text : '정보처리기사',
							value : '1'
						}, {
							text : 'SQLD',
							value : '2'
						}, {
							text : '빅데이터분석기사',
							value : '3'
						}, {
							text : '정보처리기능사',
							value : '4'
						}, {
							text : '정보처리산업기사',
							value : '5'
						}, {
							text : '-',
							value : '6'
						} ]
					}
				}
			}, {
				header : '평가',
				name : 'grade',
				formatter : 'listItemText',
				editor : {
					type : 'radio',
					options : {
						listItems : [ {
							text : '★☆☆☆☆',
							value : '1'
						}, {
							text : '★★☆☆☆',
							value : '2'
						}, {
							text : '★★★☆☆',
							value : '3'
						}, {
							text : '★★★★☆',
							value : '4'
						}, {
							text : '★★★★★',
							value : '5'
						} ]
					}
				}
			} ]
		});
		
		tui.Grid.applyTheme('striped', { // 테마 설정
		    cell: {
		        head: {
		            background: '#eef'
		        },
		        evenRow: {
		            background: '#fee'
		        }
		    }
		});
		
		// afterChange 이벤트 핸들러
		grid.on('afterChange', function(ev) {
			console.log('after change:', ev);

			var changes = ev.changes;
			var rowKey = changes[0].rowKey + 1;
			var columnName = changes[0].columnName;
			var value = changes[0].value;

			var student = {
				stId : rowKey,
				columnName : columnName,
				value : value,
			};

			console.log('student:', student);

			// 서버로 데이터 전송
			$.ajax({
				url : '/grid/gridUpdate', // 수정된 데이터를 처리할 서버의 엔드포인트
				type : 'POST',
				contentType : 'application/json',
				data : JSON.stringify(student),
				success : function(response) {
					// 서버의 응답을 처리 (필요하다면 추가적인 로직을 구현하세요)
					console.log(response);
				},
				error : function(xhr, status, error) {
					console.error('AJAX 오류:', status, error);
				}
			});
		});
	}

	function getGridData(clickData) {
		$.ajax({
			url : '/grid/getGridData', // 수정된 데이터를 처리할 서버의 엔드포인트
			type : 'POST',
			contentType : 'application/json',
			data : JSON.stringify(clickData),
			dataType : 'json',
			success : function(response) {
				console.log(response);
				grid.resetData(response);
			},
			error : function(xhr, status, error) {
				console.error('AJAX 오류:', status, error);
			}
		});
	}
	
	
});




</script>
</body>
</html>
