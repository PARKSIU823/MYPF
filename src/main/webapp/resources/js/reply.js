/**
 * 기술 게시판 게시물의 조회 페이지에서 사용하기 위해서 작성
 */
console.log("Reply Module.......");

var replyService = (function() {
	
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
	
	function getList(param, callback, error) {
		
		var tech_num = param.tech_num;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + tech_num + "/" + page + ".do",
				function(data) {
					if (callback) {
						callback(data);
					}
		}).fail(function(xhr, status, err){
			if (error) {
				error();
			}
		});
	}
	return {
		add : add,
		getList : getList
	};
})();