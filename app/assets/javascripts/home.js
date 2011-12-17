/**
 * Created by JetBrains RubyMine.
 * User: Administrator
 * Date: 11-12-17
 * Time: 下午5:01
 * To change this template use File | Settings | File Templates.
 */

	var t = n = 0, count;
	$(document).ready(function(){
		count=$("#banner_list ul li").length;
		$("#banner_list ul li").eq(0).addClass('selected');

		$("#banner_info").html($("#banner_list a:first-child").find("img").attr('alt'));
		$("#banner_info").click(function(){window.open($("#banner_list a:first-child").attr('href'), "_blank")});
		$("#banner li").click(function() {
			var i = $(this).text() - 1;//获取Li元素内的值，即1，2，3，4
			n = i;
			if (i >= count) return;
			$("#banner_info").html($("#banner_list a").eq(i).find("img").attr('alt'));
			$("#banner_info").unbind().click(function(){window.open($("#banner_list a").eq(i).attr('href'), "_blank")})
			$("#banner_list ul li").filter(".selected").removeClass('selected').fadeOut(500).parent().children().eq(i).addClass('selected');

			document.getElementById("banner").style.background="";
			$(this).toggleClass("on");
			$(this).siblings().removeAttr("class");
		});
		t = setInterval("showAuto()", 4000);
		$("#banner").hover(function(){clearInterval(t)}, function(){t = setInterval("showAuto()", 4000);});
	})

	function showAuto()
	{
		n = n >=(count - 1) ? 0 : ++n;
		$("#banner li").eq(n).trigger('click');
	}

