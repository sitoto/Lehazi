/**
 * Created by JetBrains RubyMine.
 * User: Administrator
 * Date: 11-12-11
 * Time: 上午11:54
 * To change this template use File | Settings | File Templates.
 */

function DoMenu(emid){
    var obj = document.getElementById(emid);
    obj.className = (obj.className.toLowerCase() == "expanded"?"collapsed":"expanded");
}
;
