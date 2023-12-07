<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조원 평가 페이지</title>

<!-- tui css js 설정 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>



<body>

	<h3 align="center">학 생 평 가</h3>
	<div id="grid"></div>



</body>


<script>

	//console.log("${studentList}");

 var grid = new tui.Grid({
    el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    columns: [
      {//수정X
        header: '번호',
        name: 'id',
      },
      {//수정X
        header: '이름',
        name: 'name',
      },
      {//수정O
        header: '연락처',
        name: 'tel',
        editor: 'text'
      },
      {//select, 전공자 유무
          header: '전공자 유무',
          name: 'majorType',
          formatter: 'listItemText',
          editor: {
            type: 'select',
            options: {
              listItems: [
                { text: '전공자', value: '1' },
                { text: '비전공자', value: '2' }
             ]
           }
         }
       },
       {
         header: '자격증',
         name: 'certificate',
         formatter: 'listItemText',
         editor: {
           type: 'checkbox',
           options: {
             listItems: [
               { text: '정보처리기사', value: '1' },
               { text: 'SQLD', value: '2' },
               { text: '빅데이터분석기사', value: '3' },
               { text: '정보처리기능사', value: '4' },
               { text: '정보처리산업기사', value: '5' },
               { text: '-', value: '6' }
             ]
           }
         },      
        copyOptions: {
          useListItemText: true // when this option is used, the copy value is concatenated text
        }
      },
      {
        header: '평가',
        name: 'grade',
        copyOptions: {
          useListItemText: true
        },
        formatter: 'listItemText',
        editor: {
          type: 'radio',
          options: {
            listItems: [
              { text: '★☆☆☆☆', value: '1' },
              { text: '★★☆☆☆', value: '2' },
              { text: '★★★☆☆', value: '3' },
              { text: '★★★★☆', value: '4' },
              { text: '★★★★★', value: '5' }
            ]
          }
        }
      }
    ]
  });
  
  var gridData = [
	  
	  <c:forEach items="${studentList}" var="student">	  	
		{
			id : '${student.stId}',
			name: '${student.stName}',
			tel: '${student.tel}',
			majorType: '${student.majorType}',
			certificate: ['${student.certificate}'],
			grade: '${student.grade}'
		},
	  </c:forEach>

	];
  
  console.log(gridData);
  
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
  
 
/*   grid.on('beforeChange', ev => {
      console.log('before change:', ev);
    }); */
    
    
    
  grid.on('afterChange', function (ev) {
    console.log('after change:', ev);
    
    var changes = ev.changes;
    console.log('changes.columnName:', changes[0].columnName);
   var rowKey = changes[0].rowKey + 1;
   var columnName = changes[0].columnName;
   var value = changes[0].value;

   var student = {
		stId : rowKey,
		columnName : columnName,
		value : value,
	}
   
   console.log('student:', student);
   
    $.ajax({
        url: '/grid/grid03', // 서버의 엔드포인트
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(student),
        success: function (response) {
          // 서버의 응답을 처리
          grid.refreshLayout();
          console.log(response);
          
        },

      });
        
  });

  
  grid.resetData(gridData);
  
  

  
  


	
</script>




</html>