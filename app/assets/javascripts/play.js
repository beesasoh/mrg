var c = 1;
var n = 1;
var m = 0;
var d = document;
var ans = new Array;
$(document).ready(function(){
	var a = $("textarea#xas").val();
	$("#xa").remove();
	handle_ans_click(a);
});

function handle_ans_click(a){
	$("#ach li").click(function(){
		cId = this.id;
		qsn = "qn"+c;
		if(ans.indexOf(qsn) == -1){
			ans.push(qsn);
			analyse(cId,a);
		}else{
			next();
		}
	});
}

function analyse(cId,a){
	ids = cId.split("-");
	iQ = ids[0];
	iQi = "qn"+iQ;
	ic = ids[1];
	eval("var j = "+a);
	if(j[iQi] == ic){
		$("#"+cId).addClass("correct");
		updateScore();
	}else{
		$("#"+cId).addClass("wrong");
		setTimeout(function(){
			corr = iQ+"-"+j[iQi];
			$("#"+corr).addClass("correct");
		}, 500)
	}
}

function next(){
	n = c + 1;
	if(d.getElementById("q"+n) != null){
		$("#q"+n).slideDown();
		$("#q"+c).slideUp();
		c = n;
	}else{
		alert("Game over");
	}
}

function updateScore(){
	m +=1;
	document.getElementById("score").innerHTML = "Score : "+m;
}