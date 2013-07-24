var c = 1; //current 
var n = 1; //new
var m = 0; // marks
var a; //ans
var timer;
var myMin;
var c_id;
var d = document;
var ans = new Array;
$(document).ready(function(){
	a = $("textarea#xas").val();
	myMin = MRG_PLAY.getNumberOfQuestions();
	c_id = MRG_PLAY.getCourseId();
	$("#xa").remove();
	handle_ans_click();
	MRG_PLAY.startTimer();
});

function handle_ans_click(){
	$("#ach li").click(function(){
		cId = this.id;
		qsn = "qn"+c;
		if(ans.indexOf(qsn) == -1){
			ans.push(qsn);
			analyse(cId);
		}else{
			next();
		}
	});
}

function analyse(cId){
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
		//TODO handle game over
		MRG_PLAY.gameOver();
	}
}

function updateScore(){
	m +=1;
	document.getElementById("score").innerHTML = "Score : "+m;
}

var MRG_PLAY = {
	s: 00,
	startTimer : function(){
		d.getElementById("t_s").innerHTML = MRG_PLAY.addZeroPrefix(MRG_PLAY.s) +MRG_PLAY.s;
		d.getElementById("t_m").innerHTML = MRG_PLAY.addZeroPrefix(myMin) +myMin;
		if(MRG_PLAY.s != 0){
			MRG_PLAY.s--
		}else{
			if(myMin != 0){
				myMin--
				MRG_PLAY.s = 59;
			}else{
				clearTimeout(timer);
			}
		}
		timer = setTimeout("MRG_PLAY.startTimer()",1000);
	} ,

	addZeroPrefix : function(num){
		if(num < 10){
			return "0";
		}else{
			return "";
		}
	},

	gameOver : function(){
		clearTimeout(timer);
		MRG_PLAY.hideQuestions();
		MRG_PLAY.showResults();
		document.getElementById("score").innerHTML = "Results";
		f_score = MRG_PLAY.getScore();
		setTimeout(function(){
			PLAY_SCORE.anim(f_score);
		},500);
		$.post("/play/create", {course: c_id, score: f_score}, function(data){
			$("#mrg-out").html(data);
		});
	},

	hideQuestions : function(){
		$("#mrg_qns").slideUp();
	},

	showResults : function(){
		$("#mrg_play_results").fadeIn();
	},
	
	getScore : function(){
		num = MRG_PLAY.getNumberOfQuestions();
		sc = m / num * 80;

		finish_time = 60*myMin + MRG_PLAY.s;
		total_time = 60*num;
		time_bonus = finish_time / total_time * 20;

		fsc = sc + time_bonus;
		return Math.round(fsc);
	},

	getNumberOfQuestions : function(){
		eval("var j = "+a);
		num = j['num'];
		return Math.round(num);
	},
	getCourseId : function(){
		eval("var j = "+a);
		c_Id = j['cid'];
		return c_Id
	}

}

var PLAY_SCORE = {
	s    : 0,
	anim : function(sc){
		eles = document.getElementById("sss");
		ele = document.getElementById("res-inner");
		if(PLAY_SCORE.s < sc){
			ele.style.width = PLAY_SCORE.s+"%";
			if(PLAY_SCORE.s > 80){
				ele.className = 'green';
			}else if(PLAY_SCORE.s > 40){
				ele.className = 'orange'
			}else{
				ele.className = 'red'
			}
			eles.innerHTML = Math.round(PLAY_SCORE.s) +"%";
			PLAY_SCORE.s += 0.1;
			setTimeout(function(){
				PLAY_SCORE.anim(sc);	
			},5);
		}else{
			$("#mrg-out").show();
		}
	}
}