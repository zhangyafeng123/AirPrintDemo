// Box Type (商业:1, 公积金:2, 组合:3)
var boxID = 1;
//
var returnStr = "商业贷款";
//阻止事件冒泡的通用函数  
function stopBubble(e){  
	// 如果传入了事件对象，那么就是非ie浏览器  
	if(e&&e.stopPropagation){  
		//因此它支持W3C的stopPropagation()方法  
		e.stopPropagation();  
	}else{  
		//否则我们使用ie的方法来取消事件冒泡  
		window.event.cancelBubble = true;  
	}  
} 

function setNum(num,event)
{
	stopBubble(event);
	var result = $("input.active").attr("value");
	tmp = result;
	if ("" == tmp)	// 空值
	{
		result = num;
	}
	else
	{
		if (!isNaN(tmp))	// 非空值
		{
			result += num;	// 是数值
			if (isNaN(result))	// 不是数值
			{
				result = tmp;
			}
		}
	}
	$("input.active").attr("value", result);
	cal();
}


function LoanType(id)
{
	var x = "#" + id;	
	$("#dktype").html($(x).html());
	
	var sdkqx = "<div class='listtop'></div>" 
		+ "<div class='btn' ontouchend='javascipt:nxListLi(1,this,6.00,0)'>1</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(1,this,6.15,0)'>2</div>"										
		+ "<div class='btn' ontouchend='javascipt:nxListLi(1,this,6.15,0)'>3</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(1,this,6.40,0)'>4</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(1,this,6.40,0)'>5</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(1,this,6.55,0)'>10</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(1,this,6.55,0)'>15</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(1,this,6.55,0)'>20</div>";
		
	var gdkqx = "<div class='listtop'></div>" 
		+ "<div class='btn' ontouchend='javascipt:nxListLi(2,this,4.00,0)'>1</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(2,this,4.00,0)'>2</div>"										
		+ "<div class='btn' ontouchend='javascipt:nxListLi(2,this,4.00,0)'>3</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(2,this,4.00,0)'>4</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(2,this,4.00,0)'>5</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(2,this,4.50,0)'>10</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(2,this,4.50,0)'>15</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(2,this,4.50,0)'>20</div>";
		
	var zdkqx = "<div class='listtop'></div>" 
		+ "<div class='btn' ontouchend='javascipt:nxListLi(3,this,6.00,4.00)'>1</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(3,this,6.15,4.00)'>2</div>"										
		+ "<div class='btn' ontouchend='javascipt:nxListLi(3,this,6.15,4.00)'>3</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(3,this,6.40,4.00)'>4</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(3,this,6.40,4.00)'>5</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(3,this,6.55,4.50)'>10</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(3,this,6.55,4.50)'>15</div>"
		+ "<div class='btn' ontouchend='javascipt:nxListLi(3,this,6.55,4.50)'>20</div>";	
    
	switch(id)
	{
		case 'sy':
			boxID = 1;
			$("#dkqxlist").html(sdkqx);
			$(".lv input").val("");
			$(".dkqx").html("");
            returnStr = "商业贷款";
			break;
		case 'gjj':
			boxID = 2;
			$("#dkqxlist").html(gdkqx);
			$(".lv input").val("");
			$(".dkqx").html("");
            returnStr = "公积金贷款";
			break;
		case 'zh':
			$("#dkqxlist").html(zdkqx);
			$(".lv input").val("");
			$(".dkqx").html("");			
			boxID = 3;
            returnStr = "组合贷款";
			break
		default:
			boxID = 1;
			break;
	}
	$(x).parent(".dlist").slideUp();
	$(".dlist .btn").removeClass("active");
	$(x).addClass("active");
	$(".dtit").removeClass("active");
	$(".dtit." + id).addClass("active");
	if (boxID == 3)
	{
		$(".item.zhg").show();
		$(".item.nzh").hide();
	}
	else
	{
		$(".item.nzh").show();
		$(".item.zhg").hide();	
	}
	cal();
    return returnStr;
}

function showList(event,obj)
{
	listUp();
	stopBubble(event);
	if ($(obj).siblings(".dlist").is(':visible'))
	{
		$(obj).siblings(".dlist").slideUp();
	}
	else
	{
		$(obj).siblings(".dlist").slideDown();
	}
	$("input").blur();
    
}

function nxListLi(type,con,lv,glv)
{
    
	listUp();
	$(con).parents(".dlist").slideUp();
	var year = $(con).html();
	$(".dlist .btn").removeClass("active");
	$(con).addClass("active");
	$(con).parents(".dlist").siblings(".dkqx").html(year);
	var hkys = eval(year)*12;
	$("#xkhys").html(hkys);
	$("#jhkys").html(hkys);
	
	if (3 != type)
	{
		if ("基准利率" == $(".dklv").html())
		{
			lv = lv.toFixed(2);
			$(".lv input").val(lv);
			$(".lv input").attr("class","jz");
		}
		
		if ("上浮利率" == $(".dklv").html())
		{
			lv *= 1.1;
			lv = lv.toFixed(2);
			$(".lv input").val(lv);
			$(".lv input").attr("class","sf");	
		}
	}
	else
	{
		if ("基准利率" == $("#sdklv").html())
		{
			lv = lv.toFixed(2);
			$("#slv input").val(lv);
			$("#slv input").attr("class","jz");		
		}
		if ("上浮利率" == $("#sdklv").html())
		{
			lv *= 1.1;
			lv = lv.toFixed(2);
			$("#slv input").val(lv);
			$("#slv input").attr("class","sf");	
		}
		if ("基准利率" == $("#gdklv").html())
		{
			glv = glv.toFixed(2);
			$("#glv input").val(glv);
			$("#glv input").attr("class","jz");		
		}
		if ("上浮利率" == $("#gdklv").html())
		{
			glv *= 1.1;
			glv = glv.toFixed(2);
			$("#glv input").val(glv);
			$("#glv input").attr("class","sf");	
		}		
	}	
	
	cal();
    
}		

function lvListLi(con)
{
	var cn = $(con).html();
	$(".dlist .btn").removeClass("active");
	$(con).addClass("active");
	$(con).parents(".dlist").siblings(".dklv").html(cn);

	var lv = $(con).parents(".innerbox-p8").siblings(".innerbox-p2").find("input").val();
	var jlv = eval(lv + "/" + 1.1).toFixed(2);
	var slv = eval(lv + "*" + 1.1).toFixed(2);
	
	if ("基准利率" == cn)
	{
		if ("sf" == $(con).parents(".innerbox-p8").siblings(".innerbox-p2").find("input").attr("class"))
		{
			$(con).parents(".innerbox-p8").siblings(".innerbox-p2").find("input").val(jlv);
			$(con).parents(".innerbox-p8").siblings(".innerbox-p2").find("input").attr("class","jz");
		}
	}
	
	if ("上浮利率" == cn)
	{
		if ("jz" == $(con).parents(".innerbox-p8").siblings(".innerbox-p2").find("input").attr("class"))
		{
			$(con).parents(".innerbox-p8").siblings(".innerbox-p2").find("input").val(slv);
			$(con).parents(".innerbox-p8").siblings(".innerbox-p2").find("input").attr("class","sf");				
		}			
	}
	
	$(con).parents(".dlist").slideUp();
	cal();		
}

function listUp()
{	
	if($(".dlist").is(':visible'))
	{
		$(".dlist").slideUp();
	}
}

function verify()
{
	var gg = $("input.active").attr("value");
	if (isNaN(gg))	// 非数值
	{
		alert("请重新输入合法数值！");
		$("input.active").attr("value", "");
	}
	else{
		cal();
	}
}

function InputEvent(event,obj)
{
	listUp();
	stopBubble(event);
	$("input").removeClass("active");
	$(obj).addClass("active");
}


function debj(dk, lv, qx)
{
	var myhk = "";
	lv = eval(lv)/1200;
	var hkys = eval(qx)*12;
	var t1 = dk/hkys;
	var tmp = 0;
	var mydj = 0;
	for (var i = 1; i <= 2; i++)
	{
		var dyhk = t1 + (dk - t1*(i-1))*lv;
		dyhk = Math.round(dyhk*Math.pow(10,2))/Math.pow(10,2);
		if (i == 1)
		{				
			$("#jmyhk").html(dyhk);
			tmp = dyhk;
		}
		if (i == 2)
		{		
			mydj = tmp - dyhk;
			mydj = Math.round(mydj*Math.pow(10,2))/Math.pow(10,2);
			$("#jmydj").html(mydj);
		}
	}
	
}

function debx(dk, lv, qx)
{
	var myhk = "";
	lv = eval(lv)/1200;
	var t1 = 1 + lv;
	var hkys = eval(qx)*12;
	var t2 = Math.pow(t1,hkys);
	var t3 = Math.pow(t1,hkys) - 1;
	myhk = dk * lv * t2 / t3;
	myhk = Math.round(myhk*Math.pow(10,2))/Math.pow(10,2);
	$("#xmyhk").html(myhk);
}

function zdebj(zsdkje, zgdkje, zslv, zglv, dkqx)
{
	var zsdk = eval(zsdkje)*10000;
	var zgdk = eval(zgdkje)*10000;
	var myhk = "";

	zslv = eval(zslv)/1200;
	zglv = eval(zglv)/1200;
	var hkys = eval(dkqx)*12;
	var t1 = zsdk/hkys;
	var z1 = zgdk/hkys;
	
	var tmp = 0;
	var mydj = 0;	
	
	for (var i = 1; i <= 2; i++)
	{
		var dyhk = (t1 + (zsdk - t1*(i-1))*zslv) + (z1 + (zgdk - z1*(i-1))*zglv) ;
		dyhk = Math.round(dyhk*Math.pow(10,2))/Math.pow(10,2);
		if (i == 1)
		{
			$("#jmyhk").html(dyhk);	
			tmp = dyhk;			
		}
		if (i == 2)
		{
			mydj = tmp - dyhk;
			mydj = Math.round(mydj*Math.pow(10,2))/Math.pow(10,2);
			$("#jmydj").html(mydj);
		}		
	}
}

function zdebx(zsdkje, zgdkje, zslv, zglv, dkqx)
{
	var zsdk = eval(zsdkje)*10000;
	var zgdk = eval(zgdkje)*10000;	                         
	var myhk = "";
	var myhk1 = "";
	var myhk2 = "";
	zslv = eval(zslv)/1200;
	zglv = eval(zglv)/1200;
	
	var t1 = 1 + zslv;
	var z1 = 1 + zglv;
	var hkys = eval(dkqx)*12;
	var t2 = Math.pow(t1,hkys);
	var t3 = Math.pow(t1,hkys) - 1;	
	var z2 = Math.pow(z1,hkys);
	var z3 = Math.pow(z1,hkys) - 1;	
	myhk1 = zsdk * zslv * t2 / t3;
	myhk2 = zgdk * zglv * z2 / z3;	
	myhk = myhk1 + myhk2;
	myhk = Math.round(myhk*Math.pow(10,2))/Math.pow(10,2);
	$("#xmyhk").html(myhk);	
}

function sydk(bj)
{
	var sf = "";
	var dkje = $("#dkje").attr("value");
	var lv = $(".lv > input").val();
	var dkqx = $("#dkqx").html();
	if ("" != dkje)
	{
		dkje = eval(dkje)*10000;
		sf = bj - dkje;
		
		if ("" != lv && "" != dkqx)
		{
			debx(dkje, lv, dkqx);
			debj(dkje, lv, dkqx);	
		}
	}
	$("#xsfje").html(sf/10000);
	$("#jsfje").html(sf/10000);
}

function gjj(bj)
{
	var sf = "";
	var dkje = $("#dkje").attr("value");
	var lv = $(".lv > input").val();
	var dkqx = $("#dkqx").html();
	if ("" != dkje)
	{
		dkje = eval(dkje)*10000;
		sf = bj - dkje;
		
		if ("" != glv && "" != dkqx)
		{
			debx(dkje, lv, dkqx);
			debj(dkje, lv, dkqx);	
		}
	}
	$("#xsfje").html(sf/10000);
	$("#jsfje").html(sf/10000);
    
}

function zh(bj)
{
	var sf = "";
	var zsdkje = $("#zsdkje").attr("value");
	var zgdkje = $("#zgdkje").attr("value");
	var slv = $("#slv input").attr("value");
	var glv = $("#glv input").attr("value");
	var dkqx = $("#dkqx").html();
	var myhk = "";
	if ("" != zsdkje && "" != zgdkje)
	{
		var zdkje = eval(zsdkje + "+" + zgdkje)*10000;
		sf = bj - zdkje;
	}
	
	if ("" != zsdkje && "" != zgdkje)
	{
		if ("" != slv && "" != glv && "" != dkqx)
		{
			zdebx(zsdkje, zgdkje, slv, glv, dkqx);
			zdebj(zsdkje, zgdkje, slv, glv, dkqx);	
		}
	}	
	$("#xsfje").html(sf/10000);
	$("#jsfje").html(sf/10000);
}

function cal()
{
    
    
	var sum = "";	// 总价
	var dj = $("#dj").attr("value");	// 单价
	var mj = $("#mj").attr("value");	// 面积
	var zhyh = $("#zhyh").attr("value");	// 折后优惠
	var zk = $("#zk").attr("value");	// 折扣
    var sss = $("#xsfje").html();//首付
    var allmoney = $("#xkhys").html();//还款月数
    var mmm = $("#xmyhk").html();//每月还款多少
	var change = "";
	
	if ("" != dj && "" != mj)	
	{
		sum = eval(dj + "*" + mj);	// 总价		
		
		if ("" != zk && "" != zhyh)	// 优惠并折扣
		{
			sum = eval(sum + "*" + zk + "/" + 10);			
			sum = eval(sum + "-" + zhyh);
		}
		if ("" != zhyh && "" == zk)	// 优惠不折扣
		{
			sum = eval(sum + "-" + zhyh);
		}
		
		if ("" == zhyh && "" != zk)	// 折扣不优惠
		{
			sum = eval(sum + "*" + zk + "/" + 10);			
		}

		sum = Math.round(sum*Math.pow(10,2))/Math.pow(10,2);
		$("#sum").attr("value", sum/10000);	
	}
	
	if ("" != sum)
	{
		switch(boxID)
		{
			case 1:
				sydk(sum);
				break;
			case 2:
				gjj(sum);
				break;
			case 3:
				zh(sum);
				break;
			default:
				sydk(sum);
				break;
		}	
	}
    /*
     var sum = "";    // 总价
     var dj = $("#dj").attr("value");    // 单价
     var mj = $("#mj").attr("value");    // 面积
     var zhyh = $("#zhyh").attr("value");    // 折后优惠
     var zk = $("#zk").attr("value");    // 折扣
     */
    return sum +"-"+ dj + "-" + mj + "-" + zhyh + "-" + zk + "-" + sss + "-" + allmoney + "-" + mmm;
}

function reset()
{
	$("input").removeClass("active");
	$("input").attr("value", "");
	$(".dkqx").html("");
	$(".lv > input").val("");
	$("#zsdkje").val("");
	$("#zgdkje").val("");
	$("#xsfje").html("");
	$("#xkhys").html("");
	$("#xmyhk").html("");
	$("#jsfje").html("");
	$("#jhkys").html("");
	$("#jmyhk").html("");	
	$("#jmydj").html("");	
	$("#slv input").attr("value", "4.5");
	$("#glv input").attr("value", "4.5");
	$("#sum").val("");
}

function doBack()
{
	window.close();
}

function del(event)
{
	stopBubble(event);
	var result = $("input.active").attr("value");
	if ("" != result) 
	{
		result = result.substring(0, result.length - 1);
		$("input.active").attr("value", result);
	}
	cal();
}

