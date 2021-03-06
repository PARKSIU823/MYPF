/**
 * 기술 게시판 게시물의 조회 페이지에서 사용하기 위해서 작성
 */
console.log("Reply Module.......");

var replyService = (function() {
	// 댓글 작성
	function add(comm_con, callback, error) {
		console.log("add reply.............");
		
		$.ajax({
				type : 'post',
				url : '/replies/new.do',
				data : JSON.stringify(comm_con),
				contentType : "application/json; charset=utf-8",
				success : function(result, status, xhr) {
					if (callback) {
						callback(result);
					}
				},
				error : function(xhr, status, er) {
					if (error) {
						error(er);
					}
				}
		})
	}
	// 댓글 목록 조회
	function getList(param, callback, error) {
		
		var tech_num = param.tech_num;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + tech_num + "/" + page + ".do",
				function(data) {
					if (callback) {
						callback(data.commCnt, data.list); // 댓글 숫자와 목록을 가져오는 경우
					}
		}).fail(function(xhr, status, err){
			if (error) {
				error();
			}
		});
	}
	// 댓글 삭제
	function remove(comm_num, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/replies/' + comm_num + '.do',
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				} 
			}
		});
	}
	// 댓글 수정
	function update(comm_con, callback, error) {
		
		console.log("tech_num", comm_con.comm_num);

		$.ajax({
			type : 'put',
			url : '/replies/' + comm_con.comm_num + '.do',
			data : JSON.stringify(comm_con),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback) {
				callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	// 댓글 조회
	function get(comm_num, callback, error) {
		$.get("/replies/" + comm_num + ".do", function(result){
		
			if(callback) {
				callback(result);
			}
		
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}	
	// 댓글 시간 처리(당일 등록 : 시/분/초, 24시간 전 등록 : 년/월/일)
	function displayTime(timeValue) {
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap < (1000 * 60 * 60 * 24)) {
			
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0' ) + hh, ':', (mi > 9 ? '' : '0') + mi,
				':', (ss > 9 ? '' : '0' ) + ss ].join('');
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
				(dd > 9 ? '' : '0') + dd ].join('');
		}
	};
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};
})();